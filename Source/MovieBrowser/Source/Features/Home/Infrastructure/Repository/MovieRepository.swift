//
//  MovieRepository.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Core
import Foundation

final class MovieRepository: MovieRepositoryProtocol {
  private let apiClient: ApiClientProtocol
  private let decoder: JSONDecoder
  private let apiKey: String
  private let language: String?
  private let region: String?

  enum MovieRepositoryError: Error {
    case invalidRequest
    case invalidResponse(status: Int? = nil)
  }

  init(apiClient: ApiClientProtocol,
       apiKey: String,
       language: String?,
       region: String?,
       decoder: JSONDecoder = JSONDecoder()) {
    self.apiClient = apiClient
    self.decoder = decoder
    self.apiKey = apiKey
    self.language = language
    self.region = region
  }

  func fetchMovies(category: MovieCategory, page: Int) async throws -> MovieCatalogDto {
    let data = try await apiClient.execute(
      endpoint: makeCatalogEndpoint(category, page: page)
    )
    return try decoder.decode(MovieCatalogDto.self, from: data)
  }

  private func makeCatalogEndpoint(_ category: MovieCategory, page: Int) -> Endpoint {
    HomeEndpoint(route: HomeApiRoute(category: category),
                 apiKey: apiKey,
                 language: language,
                 region: region,
                 page: page)
  }
}
