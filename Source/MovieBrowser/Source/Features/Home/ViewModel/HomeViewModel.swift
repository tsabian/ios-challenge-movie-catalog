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
  private let useCase: FetchHomeMoviesUseCaseProtocol
  @Published var state: HomeState = .idle
  @Published var searchText: String = ""
  @Published var currentCategory: MovieCategory = .nowPlaying

  init(useCase: FetchHomeMoviesUseCaseProtocol) {
    self.useCase = useCase
  }

  func load() async {
    state = .loading
    await fetch()
  }

  func select(category: MovieCategory) async {
    currentCategory = category
    await fetch()
  }

  private func fetch() async {
    do {
      let content = try await useCase.execute(category: currentCategory, page: 1)
      state = content.movies.isEmpty && content.rankedMovies.isEmpty ? .empty :
        .loaded(content: content)
    } catch {
      state = .error(error.localizedDescription)
    }
  }
}
