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

final class SearchViewModel: SearchViewModelProtocol {
  private let searchUseCase: SearchMovieUseCaseProtocol
  private let genreUseCase: FetchGenreUseCaseProtocol

  @Published private(set) var state: SearchState = .idle
  @Published private(set) var navigate: SearchFeatures? = .none
  @Published var page = 1

  private var title: String?
  private var genres: [GenreModel] = []

  init(searchUseCase: SearchMovieUseCaseProtocol,
       genreUseCase: FetchGenreUseCaseProtocol) {
    self.searchUseCase = searchUseCase
    self.genreUseCase = genreUseCase
  }

  func search(movie title: String) async {
    self.title = title
    state = .loading
    do {
      try await loadGenresIfNeeded()
      let movies = try await searchUseCase.find(movie: title, page: page)
      state = movies.totalResults == 0 ? .empty : .loaded(content: movies)
    } catch {
      state = .error(error.localizedDescription)
    }
  }

  func getGenreName(id: Int) -> String {
    genres.first(where: { $0.id == id })?.name ?? "Unknown"
  }

  func reset() {
    state = .idle
  }

  func requestDetails(selectedMovie: SearchMovieResultModel) {
    let movie = MovieModel(id: selectedMovie.id,
                           title: selectedMovie.title,
                           posterPath: selectedMovie.posterPath,
                           backdropPath: nil,
                           rank: 0)
    navigate = .movieDetails(movie: movie)
  }

  private func loadGenresIfNeeded() async throws {
    guard genres.isEmpty else { return }
    genres = try await genreUseCase.fetch()
  }
}
