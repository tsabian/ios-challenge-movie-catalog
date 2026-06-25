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
  var backdropPath: String? { get }
  var imagePreview: Image? { get }
  var isBookmark: Bool { get }

  func loadIfNeeded() async
  func requestReviews()
  func requestCast()
  func makeMovieURL() -> URL?
  func addOrRemoveWatchList()
  func requestRecomendations()
  func requestWatchProviders()
}
