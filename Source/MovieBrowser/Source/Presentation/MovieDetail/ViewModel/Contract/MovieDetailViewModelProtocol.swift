//
//  MovieDetailViewModelProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import Foundation
import UIKit

protocol MovieDetailViewModelProtocol: ObservableObject {
  var state: MovieDetailState { get }
  var movieTitle: String { get }
  var backdropPath: String? { get }
  var imagePreview: UIImage? { get }
  var isBookmark: Bool { get }

  func loadIfNeeded() async
  func makeMovieURL() -> URL?
  func addOrRemoveWatchList()
  func loadCastIfNeeded() async
  func loadReviewsIfNeeded() async
  func loadWatchProvidersIfNeeded() async
  func loadRecomendationsIfNeeded() async
}
