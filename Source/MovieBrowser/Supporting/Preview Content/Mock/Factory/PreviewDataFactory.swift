//
//  PreviewDataFactory.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 26/05/26.
//

import Core
import Foundation

extension MovieCategory {
  var fileMock: String {
    "\(rawValue.lowercased()).json"
  }
}

struct PreviewDataFactory {
  private let bundle: Bundle

  static let shared = PreviewDataFactory()

  private init(bundle: Bundle = .main) {
    self.bundle = bundle
  }

  func makeMovieCatalog(for category: MovieCategory) throws -> MovieCatalogDto {
    try decode(category.fileMock)
  }

  func makeMovieDetail() throws -> MovieDetailDto {
    try decode("movie-details.json")
  }

  func makeMovieReviews() throws -> ReviewCatalogDto {
    try decode("reviews.json")
  }

  private func decode<T: Decodable>(_ file: String) throws -> T {
    do {
      return try bundle.decode(file)
    } catch let error as DecodingError {
      fatalError("❌ Decode: \(error)")
    } catch {
      fatalError("❌ Failed: \(error)")
    }
  }
}
