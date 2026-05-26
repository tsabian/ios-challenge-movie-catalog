//
//  HomeViewModelProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

@MainActor
protocol HomeViewModelProtocol: ObservableObject {
  var searchText: String { get set }
  var currentCategory: MovieCategory { get set }
  var rankedMovies: [HomeMovieModel] { get }
  var movies: [HomeMovieModel] { get }

  func fetch()
}
