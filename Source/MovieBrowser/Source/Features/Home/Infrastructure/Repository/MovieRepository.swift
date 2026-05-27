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
  private let baseURL = AppEnvironment.current.value(for: .tmdbApiBaseUrl)

  enum MovieRepositoryError: Error {
    case invalidRequest
    case invalidResponse
  }

  init(apiClient: ApiClientProtocol,
       decoder: JSONDecoder = JSONDecoder()) {
    self.apiClient = apiClient
    self.decoder = decoder
  }

  func fetchMovies(service: HomeService) async throws -> MovieCatalogDto {
    let result = try await apiClient.execute(endpoint: service)
    if let status = result.response as? HTTPURLResponse,
       (200 ..< 300).contains(status.statusCode) {
      return try decoder.decode(MovieCatalogDto.self, from: result.data)
    } else {
      throw MovieRepositoryError.invalidResponse
    }
  }
}
