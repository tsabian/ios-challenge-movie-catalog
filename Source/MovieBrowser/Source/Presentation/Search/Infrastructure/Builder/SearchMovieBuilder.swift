//
//  SearchMovieBuilder.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/06/26.
//

import Core
import Foundation

struct SearchMovieBuilder {
  private let apiClient: ApiClientProtocol
  private let apiKey: String
  private let language: String?
  private let region: String?
  private let dataCache: NSCache<NSString, NSData>

  init(
    apiClient: ApiClientProtocol,
    apiKey: String,
    language: String?,
    region: String?,
    dataCache: NSCache<NSString, NSData>
  ) {
    self.apiClient = apiClient
    self.apiKey = apiKey
    self.language = language
    self.region = region
    self.dataCache = dataCache
  }

  func build() -> SearchViewModel {
    let searchUseCase = SearchMovieUseCase(repository: makeSearchRepository())
    let genreUseCase = FetchGenreUseCase(repository: makeGenreRepository())
    return SearchViewModel(searchUseCase: searchUseCase, genreUseCase: genreUseCase)
  }

  private func makeSearchRepository() -> SearchRepository {
    let dependencies = SearchRepositoryDependencies(apiClient: apiClient,
                                                    apiKey: apiKey,
                                                    language: language,
                                                    region: region,
                                                    includeAdult: false,
                                                    searchMovieAdapter: .init())
    return SearchRepository(apiClient: apiClient,
                            dependencies: dependencies)
  }

  private func makeGenreRepository() -> GenreRepository {
    let provider = ResourceCacheProvider<NSData>(cache: dataCache)
    let dependencies = GenreRepositoryDependencies(
      apiKey: apiKey,
      language: language,
      genreAdapter: .init(),
      genreProvider: provider
    )
    return GenreRepository(apiClient: apiClient,
                           dependencies: dependencies)
  }
}
