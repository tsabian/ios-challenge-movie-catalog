//
//  MovieDetailViewModelProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import SwiftUI

protocol MovieDetailViewModelProtocol: ObservableObject {
  var state: MovieDetailState { get }
  var movieTitle: String { get }
  var backdropPath: String { get }

  func loadIfNeeded() async
  func requestNextPageForReviews()
  func requestCast()
}
