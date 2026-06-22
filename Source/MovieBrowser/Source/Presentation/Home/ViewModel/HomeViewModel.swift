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
  private let homeContentUseCase: FetchHomeContentUseCaseProtocol
  private let movieCatalogUseCase: FetchMovieCatalogUseCaseProtocol

  @Published private(set) var state: HomeState = .idle
  @Published private(set) var isLoadingNextPage = false
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

  func loadNextPage() async {
    guard !isLoadingNextPage,
          let content,
          content.movieCatalog.page < content.movieCatalog.totalPages else {
      return
    }

    isLoadingNextPage = true
    defer {
      isLoadingNextPage = false
    }

    do {
      let nextPage = content.movieCatalog.page + 1
      let nextCatalog = try await movieCatalogUseCase.fetch(by: currentCategory,
                                                            page: nextPage)
      page = nextPage
      let updatedCatalog = makeUpdatedCatalog(content, nextCatalog)
      state = .loaded(content: HomeContentModel(rankedMovies: content.rankedMovies,
                                                movieCatalog: updatedCatalog))
    } catch {
      state = .loaded(content: content)
    }
  }

  private func fetch() async {
    do {
      let content = try await homeContentUseCase.execute(category: currentCategory, page: 1)
      self.content = content
      state = content.movieCatalog.movies.isEmpty && content.rankedMovies.isEmpty ? .empty :
        .loaded(content: content)
    } catch {
      state = .error(error.localizedDescription)
    }
  }

  private func fetchCatalog() async {
    do {
      let catalog = try await movieCatalogUseCase.fetch(by: currentCategory, page: page)
      state = .loaded(content: HomeContentModel(rankedMovies: content?.rankedMovies ?? [],
                                                movieCatalog: catalog))
    } catch {
      state = .error(error.localizedDescription)
    }
  }

  private func makeUpdatedCatalog(_ content: HomeContentModel,
                                  _ nextCatalog: MovieCatalogModel) -> MovieCatalogModel {
    var movies = content.movieCatalog.movies
    movies.append(contentsOf: nextCatalog.movies)
    return MovieCatalogModel(page: nextCatalog.page,
                             movies: movies,
                             totalPages: nextCatalog.totalPages,
                             totalResults: nextCatalog.totalResults)
  }
}
