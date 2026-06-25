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

  func select(category: MovieCategory) async {
    currentCategory = category
    await fetchCatalog(category: category)
  }

  func fetchNextPage() async {
    guard !isLoadingNextPage,
          let content,
          let catalog = content.movieCatalog[currentCategory],
          catalog.page < catalog.totalPages else {
      return
    }
    isLoadingNextPage = true
    defer {
      isLoadingNextPage = false
    }
    do {
      let nextCatalog = try await nextPageMovieCatalogUseCase.execute(by: currentCategory,
                                                                      currentPage: catalog.page,
                                                                      totalPages: catalog.totalPages)
      let updatedCatalog = makeUpdatedCatalog(content, nextCatalog)
      var currentCatalog = content.movieCatalog
      currentCatalog[currentCategory] = updatedCatalog
      let updatedContent = HomeContentModel(rankedMovies: content.rankedMovies,
                                            movieCatalog: currentCatalog)
      self.content = updatedContent
      state = .loaded(content: updatedContent)
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
      let isMoviesEmpty = (content.movieCatalog[currentCategory]?.movies ?? []).isEmpty
      state = isMoviesEmpty ? .empty : .loaded(content: content)
    } catch {
      state = .error(error.localizedDescription)
    }
  }

  private func fetchCatalog(category: MovieCategory) async {
    if content?.movieCatalog[category] != nil {
      return
    }
    do {
      let requestCategory = category
      let catalog = try await nextPageMovieCatalogUseCase.execute(by: requestCategory,
                                                                  currentPage: 0,
                                                                  totalPages: 1)
      guard currentCategory == requestCategory else { return }
      var currentCatalog = content?.movieCatalog ?? [:]
      currentCatalog[currentCategory] = catalog
      let updatedContent = HomeContentModel(rankedMovies: content?.rankedMovies ?? [],
                                            movieCatalog: currentCatalog)
      content = updatedContent
      state = .loaded(content: updatedContent)
    } catch {
      state = .error(error.localizedDescription)
    }
  }

  private func makeUpdatedCatalog(_ content: HomeContentModel,
                                  _ nextCatalog: MovieCatalogModel) -> MovieCatalogModel {
    var movies = content.movieCatalog[currentCategory]?.movies ?? []
    movies.append(contentsOf: nextCatalog.movies)
    return MovieCatalogModel(page: nextCatalog.page,
                             movies: movies,
                             totalPages: nextCatalog.totalPages,
                             totalResults: nextCatalog.totalResults)
  }
}
