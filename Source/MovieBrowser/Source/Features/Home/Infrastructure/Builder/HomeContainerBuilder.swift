//
//  HomeContainerBuilder.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Core

final class HomeContainerBuilder {
  private let apiClient: ApiClientProtocol

  init(apiClient: ApiClientProtocol) {
    self.apiClient = apiClient
  }

  func build() -> HomeViewModel {
    let repository = MovieRepository(apiClient: apiClient)
    let useCase = FetchHomeMoviesUseCase(repository: repository)
    return HomeViewModel(useCase: useCase)
  }
}
