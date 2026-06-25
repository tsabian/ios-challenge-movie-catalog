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
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return try decode("reviews.json", using: decoder)
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

  func makeWatchProvider() throws -> WatchProvidersDto {
    try decode("movie-watch-provider.json")
  }

  func makeRecomendation() throws -> MovieCatalogDto {
    try decode("recommendations.json")
  }

  private func decode<T: Decodable>(_ file: String, using decoder: JSONDecoder = .init()) throws -> T {
    do {
      return try bundle.decode(file, using: decoder)
    } catch let error as DecodingError {
      debugPrint("❌ Decode: \(error)")
      fatalError("❌ Decode: \(error)")
    } catch {
      debugPrint("❌ Decode: \(error)")
      fatalError("❌ Decode: \(error)")
    }
  }
}
