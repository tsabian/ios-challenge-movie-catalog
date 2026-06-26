//
//  WatchlistViewModelMockFactory.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

enum WatchlistViewModelMockFactory {
  @MainActor
  static func make() -> WatchListViewModelMock {
    WatchListViewModelMock()
  }
}
