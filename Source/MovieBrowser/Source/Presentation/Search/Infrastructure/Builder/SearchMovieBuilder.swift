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
    let dependencies = SearchRepositoryDependencies(apiClient: apiClient,
                                                    apiKey: apiKey,
                                                    language: language,
                                                    region: region,
                                                    includeAdult: false,
                                                    searchMovieAdapter: .init())
    let searchRepository = SearchRepository(dependencies: dependencies)
    let genreDependencies = GenreRepositoryDependencies(
      apiClient: apiClient,
      apiKey: apiKey,
      language: language,
      genreAdapter: .init()
    )
    let provider = ResourceCacheProvider<NSData>(cache: dataCache)
    let genreRepository = GenreRepository(dependencies: genreDependencies,
                                          genreProvider: provider)
    let searchUseCase = SearchMovieUseCase(repository: searchRepository)
    let genreUseCase = FetchGenreUseCase(repository: genreRepository)
    return SearchViewModel(searchUseCase: searchUseCase,
                           genreUseCase: genreUseCase)
  }
}
