//
//  SearchRouter.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/06/26.
//

import SwiftUI

enum SearchFeatures: Hashable {
  case movieDetails(movie: MovieModel)
}

protocol SearchRouterProtocol {
  func openMovieDetails(movie: MovieModel)
  func popToPrevious()
  func popToRoot()
}

@MainActor
@Observable
final class SearchRouter: SearchRouterProtocol {
  var path: [SearchFeatures] = []

  func openMovieDetails(movie: MovieModel) {
    path.append(.movieDetails(movie: movie))
  }

  func popToPrevious() {
    path.removeLast()
  }

  func popToRoot() {}
}
