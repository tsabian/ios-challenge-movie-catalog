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
    let repository = makeMovieRepository()
    let homeContentUseCase = FetchHomeContentUseCase(repository: repository)
    let movieCatalogUseCase = FetchNextPageMovieCatalogUseCase(repository: repository)
    return HomeViewModel(homeContentUseCase: homeContentUseCase,
                         movieCatalogUseCase: movieCatalogUseCase)
  }

  private func makeMovieRepository() -> MovieRepository {
    let dependencies = MovieRepositoryDependencies(
      apiKey: apiKey,
      language: language,
      region: region,
      movieAdapter: .init(),
      detailAdapter: .init(),
      reviewAdapter: .init(),
      castAdapter: .init(),
      watchProvidersAdapter: .init()
    )
    return MovieRepository(apiClient: apiClient, dependencies: dependencies)
  }
}
