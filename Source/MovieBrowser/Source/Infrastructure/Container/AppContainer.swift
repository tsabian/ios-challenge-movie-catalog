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
  private let dataCache: NSCache<NSString, NSData>
  let viewModelFactory: ViewModelContainerFactory

  static let live: AppContainer = .makeLive()

  private static func makeLive() -> Self {
    let env = AppEnvironment.current.self
    let apiClient = ApiClientFactory.make(host: env.value(for: .tmdbApiBaseUrl),
                                          pinnedPublicKeyBase64Hashes: [
                                            env.value(for: .tmdbApiSslPinningKey)
                                          ])
    let imageClient = ApiClientFactory.make(host: env.value(for: .tmdbImageBaseUrl),
                                            pinnedPublicKeyBase64Hashes: [
                                              env.value(for: .tmdbImageSslPinningKey)
                                            ])
    let imageCache = NSCache<NSString, UIImage>()
    let dataCache = NSCache<NSString, NSData>()
    let viewModelDependencies = ViewModelDependencies(apiClient: apiClient,
                                                      imageClient: imageClient,
                                                      imageCache: imageCache,
                                                      dataCache: dataCache,
                                                      apiKey: env.value(for: .tmdbApiKey),
                                                      language: env.language,
                                                      region: env.region)
    let viewModelFactory = ViewModelContainerFactory(domain: viewModelDependencies)
    return .init(
      apiClient: apiClient,
      imageClient: imageClient,
      imageCache: imageCache,
      dataCache: dataCache,
      viewModelFactory: viewModelFactory
    )
  }
}
