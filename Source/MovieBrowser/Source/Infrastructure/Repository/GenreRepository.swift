//
//  GenreRepository.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/06/26.
//

import Core
import Foundation

final class GenreRepository: NetworkRepository, GenreRepositoryProtocol {
  private let dependencies: GenreRepositoryDependencies
  private let genreKey = NSString(string: "genreList")

  init(apiClient: ApiClientProtocol,
       decoder: JSONDecoder = .init(),
       dependencies: GenreRepositoryDependencies) {
    self.dependencies = dependencies
    super.init(apiClient: apiClient, decoder: decoder)
  }

  func fetch() async throws -> [GenreModel] {
    let data: Data = if let cachedData = dependencies.genreProvider.getObject(
      forKey: genreKey
    ) {
      cachedData as Data
    } else {
      try await requestAndPersist()
    }
    let dto = try decode(GenreCatalogDto.self, from: data)
    return dependencies.genreAdapter.adapt(dto: dto)
  }

  private func requestAndPersist() async throws -> Data {
    let data = try await request(endpoint: makeGenreEndpoint())
    dependencies.genreProvider.cache(object: data as NSData, for: genreKey)
    return data
  }

  private func makeGenreEndpoint() -> Endpoint {
    GenreEndpoint(apiKey: dependencies.apiKey,
                  language: dependencies.language ?? "")
  }
}
