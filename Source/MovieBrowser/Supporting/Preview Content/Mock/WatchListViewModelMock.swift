//
//  WatchListViewModelMock.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

import Combine

final class WatchListViewModelMock: WatchListViewModelProtocol {
  @Published var state: WatchListState = .idle

  func loadIfNeeded() {}

  func update(state: WatchListState) -> Self {
    self.state = state
    return self
  }

  func makeMovie(from model: MovieDetailsModel) -> MovieModel {
    .mock(id: model.id,
          title: model.title,
          posterPath: model.posterPath,
          backdropPath: model.backdropPath,
          rank: 0)
  }
}
