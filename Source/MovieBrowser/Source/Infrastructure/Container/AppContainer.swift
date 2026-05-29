//
//  AppContainer.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Core
import Foundation
import SwiftUI

@MainActor
struct AppContainer {
  private let apiClient: ApiClientProtocol
  private let imageClient: ApiClientProtocol
  private let imageCache: NSCache<NSString, UIImage>

  static let live: AppContainer = .init()

  let viewModelFactory: ViewModelContainerFactory

  private init() {
    let env = AppEnvironment.current.self
    apiClient = ApiClientFactory.make(host: env.value(for: .tmdbApiBaseUrl),
                                      pinnedPublicKeyBase64Hashes: [
                                        env.value(for: .tmdbApiSslPinningKey)
                                      ])
    imageClient = ApiClientFactory.make(host: env.value(for: .tmdbImageBaseUrl),
                                        pinnedPublicKeyBase64Hashes: [
                                          env.value(for: .tmdbImageSslPinningKey)
                                        ])
    imageCache = .init()
    let viewModelDependencies = ViewModelDependencies(apiClient: apiClient,
                                                      imageClient: imageClient,
                                                      imageCache: imageCache,
                                                      apiKey: env.value(for: .tmdbApiKey),
                                                      language: env.language,
                                                      region: env.region)
    viewModelFactory = .init(domain: viewModelDependencies)
  }
}
