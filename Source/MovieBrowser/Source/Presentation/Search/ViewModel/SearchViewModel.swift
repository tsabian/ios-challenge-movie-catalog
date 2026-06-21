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
  @Published var path = [SearchRouter]()
  @Published var page = 1

  private var title: String?

  init(searchUseCase: SearchMovieUseCaseProtocol,
       genreUseCase: FetchGenreUseCaseProtocol) {
    self.searchUseCase = searchUseCase
    self.genreUseCase = genreUseCase
    state = state
  }

  func search(movie title: String) async {
    self.title = title
    state = .loading
    do {
      let movies = try await searchUseCase.find(movie: title, page: page)
      state = .loaded(content: movies)
    } catch {
      state = .error(error.localizedDescription)
    }
  }

  func getGenreName(id: Int) async -> String {
    let genreDefault = GenreModel(id: 0, name: "Unknow")
    guard let genres = try? await genreUseCase.fetch(),
          let first = genres.first(where: { $0.id == id }) else {
      return genreDefault.name
    }
    return first.name
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
    path.append(.movieDetails(movie: movie))
  }
}
