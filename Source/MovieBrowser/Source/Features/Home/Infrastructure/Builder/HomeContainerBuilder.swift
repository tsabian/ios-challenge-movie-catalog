//
//  HomeContainerBuilder.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Core

struct HomeContainerBuilder {
  private let apiClient: ApiClientProtocol
  private let apiKey: String
  private let language: String?
  private let region: String?

  init(apiClient: ApiClientProtocol,
       apiKey: String,
       language: String?,
       region: String?) {
    self.apiClient = apiClient
    self.apiKey = apiKey
    self.language = language
    self.region = region
  }

  func build() -> HomeViewModel {
    let repository = MovieRepository(apiClient: apiClient,
                                     apiKey: apiKey,
                                     language: language,
                                     region: region)
    let movieUseCase = FetchMoviesCatalogUseCase(repository: repository)
    return HomeViewModel(movieUseCase: movieUseCase)
  }
}
