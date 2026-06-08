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
  private let movieUseCase: FetchMoviesCatalogUseCaseProtocol

  @Published private(set) var state: HomeState = .idle
  @Published var path = [HomeRouter]()
  @Published var searchText: String = ""
  @Published var currentCategory: MovieCategory = .nowPlaying

  init(movieUseCase: FetchMoviesCatalogUseCaseProtocol) {
    self.movieUseCase = movieUseCase
  }

  func load() async {
    guard case .idle = state else { return }

    state = .loading
    await fetch()
  }

  func select(category: MovieCategory) async {
    currentCategory = category
    await fetch()
  }

  func requestDetail(movie: MovieModel) {
    path.append(.movieDetails(movie: movie))
  }

  private func fetch() async {
    do {
      let content = try await movieUseCase.execute(category: currentCategory, page: 1)
      state = content.movies.isEmpty && content.rankedMovies.isEmpty ? .empty :
        .loaded(content: content)
    } catch {
      state = .error(error.localizedDescription)
    }
  }
}
