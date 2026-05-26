//
//  HomeViewModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import Combine
import SwiftUI

final class HomeViewModel: HomeViewModelProtocol {
  private let adapter: MovieAdapter
  @Published var searchText: String = ""
  @Published var currentCategory: MovieCategory = .nowPlaying
  @Published private(set) var rankedMovies: [HomeMovieModel] = []
  @Published private(set) var movies: [HomeMovieModel] = []

  init(adapter: MovieAdapter = MovieAdapter()) {
    self.adapter = adapter
  }

  func fetch() {
    rankedMovies = [
      .init(id: 1, title: "Movie 1",
            posterPath: "https://image.tmdb.org/t/p/w185/uIb9Tvae5haF0XcQBaPyufmxbb0.jpg",
            rank: 1, category: .nowPlaying),
      .init(id: 2, title: "Movie 2",
            posterPath: "https://image.tmdb.org/t/p/w185/6X4qFYBsG3bpWDG2XIKqr04kFJa.jpg",
            rank: 2, category: .nowPlaying),
      .init(id: 3, title: "Movie 3",
            posterPath: "https://image.tmdb.org/t/p/w185/io7wVbm9VKaanIcuAymCDy9dmjU.jpg",
            rank: 99, category: .nowPlaying)
    ]

    movies = [
      .init(id: 1, title: "Movie 1",
            posterPath: "https://image.tmdb.org/t/p/w185/uIb9Tvae5haF0XcQBaPyufmxbb0.jpg",
            rank: 1,
            category: .nowPlaying),
      .init(id: 2, title: "Movie 2",
            posterPath: "https://image.tmdb.org/t/p/w185/6X4qFYBsG3bpWDG2XIKqr04kFJa.jpg",
            rank: 2, category: .nowPlaying),
      .init(id: 3, title: "Movie 3",
            posterPath: "https://image.tmdb.org/t/p/w185/io7wVbm9VKaanIcuAymCDy9dmjU.jpg",
            rank: 3, category: .nowPlaying),
      .init(id: 4, title: "The Mandalorian and Grogu",
            posterPath: "https://image.tmdb.org/t/p/w185/5Vi8dSauVwH1HOsiZceDMbRr1Ca.jpg",
            rank: 4, category: .nowPlaying),
      .init(id: 5, title: "Movie 4",
            posterPath: "https://image.tmdb.org/t/p/w185/3Qud19bBUrrJAzy0Ilm8gRJlJXP.jpg",
            rank: 5, category: .nowPlaying),
      .init(id: 6, title: "The Sheep Detectives",
            posterPath: "https://image.tmdb.org/t/p/w185/6QtL9rl3Zb4d8qW6EJ4qO5hSSfU.jpg",
            rank: 6, category: .nowPlaying),
      .init(id: 7, title: "The Devil Wears Prada 2",
            posterPath: "https://image.tmdb.org/t/p/w185/xTI42pmsP5EDnvsNJPEDubwWBQO.jpg",
            rank: 7, category: .nowPlaying)
    ]
  }
}
