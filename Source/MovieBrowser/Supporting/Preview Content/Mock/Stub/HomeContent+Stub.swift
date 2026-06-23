//
//  HomeContent+Stub.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

extension HomeContentModel {
  static func mock() -> Self {
    HomeContentModel(rankedMovies: .mock(type: .topRated),
                     movieCatalog: [.nowPlaying: .mock(type: .nowPlaying)])
  }
}
