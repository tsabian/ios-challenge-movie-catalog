//
//  HomeViewModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import Combine
import Foundation

enum HomeState {
  case idle
  case loading
  case loaded(content: HomeContentModel)
  case empty
  case error(String)
}

@MainActor
final class HomeViewModel: HomeViewModelProtocol {
  @Published private(set) var state: HomeState = .idle
  @Published private(set) var isLoadingNextPage = false
  @Published private(set) var canLoadNextPage = false
  @Published var currentCategory: MovieCategory = .nowPlaying

  // MARK: - UseCases

  private let homeContentUseCase: FetchHomeContentUseCaseProtocol
  private let nextPageMovieCatalogUseCase: FetchNextPageMovieCatalogUseCaseProtocol

  private var content: HomeContentModel?

  init(homeContentUseCase: FetchHomeContentUseCaseProtocol,
       movieCatalogUseCase: FetchNextPageMovieCatalogUseCaseProtocol) {
    self.homeContentUseCase = homeContentUseCase
    nextPageMovieCatalogUseCase = movieCatalogUseCase
  }

  func load() async {
    guard case .idle = state else { return }
    state = .loading
    await fetch()
  }

  func fetch(category: MovieCategory) async {
    currentCategory = category
    await fetchNextPage(for: category)
  }

  func fetchNextPage(for category: MovieCategory) async {
    guard !isLoadingNextPage, var content else {
      return
    }

    isLoadingNextPage = true
    defer {
      isLoadingNextPage = false
    }

    do {
      try await nextPageMovieCatalogUseCase.execute(by: category,
                                                    content: &content)
      guard currentCategory == category else { return }
      self.content = content
      state = .loaded(content: content)
    } catch UseCaseError.noMorePages {
      canLoadNextPage = false
    } catch {
      state = .loaded(content: content)
    }
  }

  private func fetch() async {
    do {
      let content = try await homeContentUseCase.execute(category: currentCategory)
      self.content = content
      let isCatalogEmpty = (content.movieCatalog[currentCategory]?.movies ?? []).isEmpty
      state = isCatalogEmpty ? .empty : .loaded(content: content)
    } catch {
      state = .error(error.localizedDescription)
    }
  }
}
