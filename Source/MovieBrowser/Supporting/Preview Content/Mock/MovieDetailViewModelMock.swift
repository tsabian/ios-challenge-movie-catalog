//
//  MovieDetailViewModelMock.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import Combine

final class MovieDetailViewModelMock: MovieDetailViewModelProtocol {
  @Published var state: MovieDetailState = .idle
  @Published var backdropPath: String = "/2w4xG178RpB4MDAIfTkqAuSJzec.jpg"

  func load() async {
    state = .loaded(detail: .mock())
  }

  func requestNextPage() {}

  func change(state: MovieDetailState) -> Self {
    self.state = state
    return self
  }
}
