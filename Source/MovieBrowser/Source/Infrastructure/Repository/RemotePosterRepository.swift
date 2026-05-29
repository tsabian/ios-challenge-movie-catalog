//
//  RemotePosterRepository.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Core
import Foundation

final class RemotePosterRepository: RemotePosterRepositoryProtocol {
  private let apiClient: ApiClientProtocol

  enum RemotePosterRepositoryError: Error {
    case invalidResponse(status: Int? = nil)
  }

  init(apiClient: ApiClientProtocol) {
    self.apiClient = apiClient
  }

  func fetch(path: String, size: TMDBImageSize) async throws -> Data {
    try await apiClient.execute(endpoint: makeFetchEndpoint(path, size))
  }

  private func makeFetchEndpoint(_ path: String,
                                 _ size: TMDBImageSize) -> Endpoint {
    RemotePosterEndpoint(route: .fetch(path: path, size: size))
  }
}
