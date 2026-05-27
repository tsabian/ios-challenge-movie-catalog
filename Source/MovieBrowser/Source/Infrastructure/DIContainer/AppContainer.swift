//
//  AppContainer.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Core

@MainActor
struct AppContainer {
  private let apiClient: ApiClient

  init() {
    let hashes = [
      AppEnvironment.current.value(for: .tmdbApiSslPinningKey)
    ]
    apiClient = ApiClientFactory.make(pinnedPublicKeyBase64Hashes: hashes)
  }

  func makeHomeViewModel() -> HomeViewModel {
    let builder = HomeContainerBuilder(apiClient: apiClient)
    return builder.build()
  }
}
