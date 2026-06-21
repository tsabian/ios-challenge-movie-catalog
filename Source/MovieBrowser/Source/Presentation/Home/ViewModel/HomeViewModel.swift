//
//  HomeViewModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import Combine
import SwiftUI

enum HomeState {
  case idle
  case loading
  case loaded(content: HomeContentModel)
  case empty
  case error(String)
}

@MainActor
final class HomeViewModel: HomeViewModelProtocol {
  private let homeContentUseCase: FetchHomeContentUseCaseProtocol
  private let movieCatalogUseCase: FetchMovieCatalogUseCaseProtocol

  @Published private(set) var state: HomeState = .idle
  @Published var currentCategory: MovieCategory = .nowPlaying
  @Published var page: Int = 1

  private var content: HomeContentModel?

  init(homeContentUseCase: FetchHomeContentUseCaseProtocol,
       movieCatalogUseCase: FetchMovieCatalogUseCaseProtocol) {
    self.homeContentUseCase = homeContentUseCase
    self.movieCatalogUseCase = movieCatalogUseCase
  }

  func load() async {
    guard case .idle = state else { return }

    state = .loading
    await fetch()
  }

  func select(category: MovieCategory) async {
    currentCategory = category
    await fetchCatalog()
  }

  private func fetch() async {
    do {
      let content = try await homeContentUseCase.execute(category: currentCategory, page: 1)
      self.content = content
      state = content.movies.isEmpty && content.rankedMovies.isEmpty ? .empty :
        .loaded(content: content)
    } catch {
      state = .error(error.localizedDescription)
    }
  }

  private func fetchCatalog() async {
    do {
      let catalog = try await movieCatalogUseCase.fetch(by: currentCategory, page: page)
      state = .loaded(content: HomeContentModel(rankedMovies: content?.rankedMovies ?? [],
                                                movies: catalog.movies))
    } catch {
      state = .error(error.localizedDescription)
    }
  }
}
