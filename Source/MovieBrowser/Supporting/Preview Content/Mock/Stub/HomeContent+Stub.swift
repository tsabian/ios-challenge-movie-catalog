//
//  HomeContent+Stub.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

extension HomeContent {
  static func mock() -> Self {
    HomeContent(rankedMovies: .mock(type: .topRated),
                movies: .mock(type: .nowPlaying))
  }
}
