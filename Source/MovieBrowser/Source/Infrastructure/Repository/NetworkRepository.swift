//
//  NetworkRepository.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/06/26.
//

import Core
import Foundation

class NetworkRepository {
  private let apiClient: ApiClientProtocol
  private let decoder: JSONDecoder

  init(apiClient: ApiClientProtocol,
       decoder: JSONDecoder,
       dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate) {
    self.apiClient = apiClient
    self.decoder = decoder
    self.decoder.dateDecodingStrategy = dateDecodingStrategy
  }

  final func request<DTO: Decodable,
    Model>(endpoint: Endpoint,
           decode _: DTO.Type,
           adapt: (DTO) -> Model) async throws -> Model {
    let data = try await request(endpoint: endpoint)
    let dto = try decode(DTO.self, from: data)
    return adapt(dto)
  }

  final func request(endpoint: Endpoint) async throws -> Data {
    try await apiClient.execute(endpoint: endpoint)
  }

  final func decode<DTO: Decodable>(_ type: DTO.Type, from data: Data) throws -> DTO {
    try decoder.decode(type, from: data)
  }
}
