//
//  SearchRepository.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 19/06/26.
//

import Core
import Foundation

final class SearchRepository: SearchRepositoryProtocol {
  private let dependencies: SearchRepositoryDependencies
  private let decoder: JSONDecoder

  init(dependencies: SearchRepositoryDependencies,
       decoder: JSONDecoder = JSONDecoder()) {
    self.dependencies = dependencies
    self.decoder = decoder
  }

  func find(query: String, page: Int) async throws -> SearchMovieCatalogModel {
    let searchEndpoint = makeSearchEndpoint(query: query,
                                            includeAdult: dependencies.includeAdult,
                                            page: page)
    let data = try await dependencies.apiClient.execute(endpoint: searchEndpoint)
    let dto = try decoder.decode(MovieCatalogDto.self, from: data)
    return dependencies.searchMovieAdapter.adapt(dto: dto)
  }

  private func makeSearchEndpoint(query: String, includeAdult: Bool, page: Int) -> Endpoint {
    SearchEndpoint(route: .search,
                   query: query,
                   includeAdult: includeAdult,
                   apiKey: dependencies.apiKey,
                   language: dependencies.language,
                   region: dependencies.region,
                   page: page)
  }
}
