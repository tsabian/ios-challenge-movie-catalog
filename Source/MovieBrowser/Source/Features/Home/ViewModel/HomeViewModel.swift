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
  case loaded(content: HomeContent)
  case empty
  case error(String)
}

final class HomeViewModel: HomeViewModelProtocol {
  private let homeUseCase: FetchMoviesCatalogUseCaseProtocol
  private let detailUseCase: FetchMovieDetailUseCaseProtocol

  @Published private(set) var state: HomeState = .idle
  @Published var path = [HomeRouter]()
  @Published var searchText: String = ""
  @Published var currentCategory: MovieCategory = .nowPlaying

  init(useCase: FetchMoviesCatalogUseCaseProtocol,
       detailUseCase: FetchMovieDetailUseCaseProtocol) {
    homeUseCase = useCase
    self.detailUseCase = detailUseCase
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
    Task {
      await fetchDetail(id: movie.id)
    }
  }

  private func fetch() async {
    do {
      let content = try await homeUseCase.execute(category: currentCategory, page: 1)
      state = content.movies.isEmpty && content.rankedMovies.isEmpty ? .empty :
        .loaded(content: content)
    } catch {
      state = .error(error.localizedDescription)
    }
  }

  private func fetchDetail(id: Int) async {
    do {
      let model = try await detailUseCase.execute(movie: id)
      path.append(.movieDetails(details: model))
    } catch {
      state = .error(error.localizedDescription)
    }
  }
}
