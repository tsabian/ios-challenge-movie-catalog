//
//  MovieDetailViewModelMock.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import Combine

@MainActor
final class MovieDetailViewModelMock: MovieDetailViewModelProtocol {
  @Published var state: MovieDetailState = .idle
  @Published var backdropPath: String = "/2w4xG178RpB4MDAIfTkqAuSJzec.jpg"
  @Published var movieTitle: String = "Star Wars: O Mandaloriano e Grogu"

  func loadIfNeeded() async {
    state = .loaded(.mock())
  }

  func requestNextPageForReviews() {}
  func requestCast() {}

  func change(state: MovieDetailState) -> Self {
    self.state = state
    return self
  }
}
