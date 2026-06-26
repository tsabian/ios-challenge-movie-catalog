//
//  SearchRepository.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 19/06/26.
//

import Core
import Foundation

final class SearchRepository: NetworkRepository, SearchRepositoryProtocol {
  private let dependencies: SearchRepositoryDependencies

  init(apiClient: ApiClientProtocol,
       decoder: JSONDecoder = .init(),
       dependencies: SearchRepositoryDependencies) {
    self.dependencies = dependencies
    super.init(apiClient: apiClient, decoder: decoder)
  }

  func find(query: String, page: Int) async throws -> SearchMovieCatalogModel {
    let searchEndpoint = makeSearchEndpoint(query: query,
                                            includeAdult: dependencies.includeAdult,
                                            page: page)
    return try await request(endpoint: searchEndpoint,
                             decode: MovieCatalogDto.self) { dto in
      dependencies.searchMovieAdapter.adapt(dto: dto)
    }
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
