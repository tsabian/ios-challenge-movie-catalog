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

  func makeCasting() throws -> CastingDto {
    try decode("credits.json")
  }

  func makeSearch() throws -> MovieCatalogDto {
    try decode("search.json")
  }

  func makeGenre() throws -> GenreCatalogDto {
    try decode("genre.json")
  }

  private func decode<T: Decodable>(_ file: String) throws -> T {
    do {
      return try bundle.decode(file)
    } catch let error as DecodingError {
      debugPrint("❌ Decode: \(error)")
      fatalError("❌ Decode: \(error)")
    } catch {
      debugPrint("❌ Decode: \(error)")
      fatalError("❌ Decode: \(error)")
    }
  }
}
