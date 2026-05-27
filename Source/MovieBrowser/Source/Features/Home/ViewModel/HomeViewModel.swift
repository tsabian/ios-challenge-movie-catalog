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
    let topRated = PreviewFactory.shared.makeMovieCatalog(for: .topRated)
    rankedMovies = adapter.adapt(dto: topRated.results, for: .topRated)

    let nowPlaying = PreviewFactory.shared.makeMovieCatalog(for: .nowPlaying)
    movies = adapter.adapt(dto: nowPlaying.results, for: .nowPlaying)
  }
}
