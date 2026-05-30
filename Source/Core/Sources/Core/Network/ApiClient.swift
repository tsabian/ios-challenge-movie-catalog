//
//  ApiClient.swift
//  Core
//
//  Created by Tiago de Oliveira on 22/05/26.
//

import Foundation

public enum ApiClientError: Error, Equatable {
  case invalidResponse
  case invalidStatusCode(Int, Data)
  case noNetworkCoverage
}

public actor ApiClient: ApiClientProtocol {
  private let host: String
  private let session: URLSessionProtocol

  public init(host: String, session: URLSessionProtocol) {
    self.host = host
    self.session = session
  }

  public func execute(endpoint: Endpoint) async throws -> Data {
    guard Reachability.hasConnection() else {
      throw ApiClientError.noNetworkCoverage
    }
    let request = try await endpoint.createRequest(for: host)
    let (data, response) = try await session.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse else {
      throw ApiClientError.invalidResponse
    }
    guard (200 ... 299).contains(httpResponse.statusCode) else {
      throw ApiClientError.invalidStatusCode(httpResponse.statusCode, data)
    }
    return data
  }
}
