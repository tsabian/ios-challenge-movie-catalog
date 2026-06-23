//
//  MovieDetailViewModelMock.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import Combine
import Foundation
import SwiftUI

@MainActor
final class MovieDetailViewModelMock: MovieDetailViewModelProtocol {
  @Published var state: MovieDetailState = .idle
  @Published var backdropPath: String? = "/2w4xG178RpB4MDAIfTkqAuSJzec.jpg"
  @Published var movieTitle: String = "Star Wars: O Mandaloriano e Grogu"
  @Published var imagePreview: Image?
  @Published private(set) var isBookmark: Bool = false

  var makeMovieURLResult = URL(string: "https://www.google.com.br")

  func loadIfNeeded() async {
    state = .loaded(.mock())
    imagePreview = Image("popcorn")
  }

  func requestReviews() {}
  func requestCast() {}

  func change(state: MovieDetailState) -> Self {
    self.state = state
    return self
  }

  func makeMovieURL() -> URL? {
    makeMovieURLResult
  }

  func addOrRemoveWatchList() {
    isBookmark.toggle()
  }
}
