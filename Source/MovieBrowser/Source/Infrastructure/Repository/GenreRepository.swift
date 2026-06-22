//
//  GenreRepository.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/06/26.
//

import Core
import Foundation

final class GenreRepository: GenreRepositoryProtocol {
  private let dependencies: GenreRepositoryDependencies
  private let decoder: JSONDecoder
  private let genreKey = NSString(string: "genreList")
  private let genreProvider: ResourceCacheProvider<NSData>

  init(dependencies: GenreRepositoryDependencies,
       decoder: JSONDecoder = .init(),
       genreProvider: ResourceCacheProvider<NSData>) {
    self.dependencies = dependencies
    self.decoder = decoder
    self.genreProvider = genreProvider
  }

  func fetch() async throws -> [GenreModel] {
    let data: Data = if let cachedData = genreProvider.getObject(forKey: genreKey) {
      cachedData as Data
    } else {
      try await dependencies.apiClient.execute(endpoint: makeGenreEndpoint())
    }
    let dto = try decoder.decode(GenreCatalogDto.self, from: data)
    return dependencies.genreAdapter.adapt(dto: dto)
  }

  private func makeGenreEndpoint() -> Endpoint {
    GenreEndpoint(apiKey: dependencies.apiKey,
                  language: dependencies.language ?? "")
  }
}
