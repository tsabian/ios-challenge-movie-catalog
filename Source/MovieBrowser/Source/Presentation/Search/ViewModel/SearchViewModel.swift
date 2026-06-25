//
//  SearchViewModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 19/06/26.
//

import Combine
import Foundation

enum SearchState {
  case idle
  case loading
  case loaded(content: SearchMovieCatalogModel)
  case empty
  case error(String)
}

@MainActor
final class SearchViewModel: SearchViewModelProtocol {
  private let searchUseCase: SearchMovieUseCaseProtocol
  private let genreUseCase: FetchGenreUseCaseProtocol

  @Published private(set) var state: SearchState = .idle
  @Published var page = 1
  @Published private(set) var isLoadingNextPage = false

  private var title: String?
  private var genres: [GenreModel] = []

  init(searchUseCase: SearchMovieUseCaseProtocol,
       genreUseCase: FetchGenreUseCaseProtocol) {
    self.searchUseCase = searchUseCase
    self.genreUseCase = genreUseCase
  }

  func search(movie title: String) async {
    self.title = title
    page = 1
    state = .loading
    do {
      try await loadGenresIfNeeded()
      let requestTitle = title
      let movies = try await searchUseCase.find(movie: requestTitle, page: page)
      guard self.title == title else { return }
      state = movies.totalResults == 0 ? .empty : .loaded(content: movies)
    } catch {
      state = .error(error.localizedDescription)
    }
  }

  func loadNextPage() async {
    guard !isLoadingNextPage,
          let title,
          case let .loaded(content) = state,
          content.page < content.totalPages else {
      return
    }

    isLoadingNextPage = true
    defer { isLoadingNextPage = false }

    do {
      let nextPage = content.page + 1
      let nextCatalog = try await searchUseCase.find(movie: title, page: nextPage)
      page = nextCatalog.page
      state = .loaded(
        content: SearchMovieCatalogModel(
          page: nextCatalog.page,
          movies: content.movies + nextCatalog.movies,
          totalPages: nextCatalog.totalPages,
          totalResults: nextCatalog.totalResults
        )
      )
    } catch {
      state = .loaded(content: content)
    }
  }

  func getGenreName(id: Int) -> String {
    genres.first(where: { $0.id == id })?.name ?? "Unknown"
  }

  func reset() {
    page = 1
    title = nil
    state = .idle
  }

  private func loadGenresIfNeeded() async throws {
    guard genres.isEmpty else { return }
    genres = try await genreUseCase.fetch()
  }

  func makeMovieModel(from movie: SearchMovieResultModel) -> MovieModel {
    MovieModel(id: movie.id,
               title: movie.title,
               posterPath: movie.posterPath,
               backdropPath: nil,
               rank: 0)
  }
}
