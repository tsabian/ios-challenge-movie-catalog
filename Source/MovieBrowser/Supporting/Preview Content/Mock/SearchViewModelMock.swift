//
//  SearchViewModelMock.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 19/06/26.
//

import Combine

final class SearchViewModelMock: SearchViewModelProtocol {
  @Published var state: SearchState = .idle
  @Published var path = [SearchRouter]()
  @Published var page = 1

  var getGenreNameResult = "Unknown"

  func search(movie _: String) async {
    state = .loaded(content: .mock())
  }

  func setStateView(state: SearchState) -> Self {
    self.state = state
    return self
  }

  func getGenreName(id _: Int) async -> String {
    getGenreNameResult
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
