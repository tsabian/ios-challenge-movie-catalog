//
//  AppContainer.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Core
import Foundation
import SwiftData
import SwiftUI

@MainActor
struct AppContainer {
  private let apiClient: ApiClientProtocol
  private let imageClient: ApiClientProtocol
  private let imageCache: NSCache<NSString, UIImage>
  private let dataCache: NSCache<NSString, NSData>
  private let container: ModelContainer
  private let modelContext: ModelContext

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
    do {
      let modelContainer = try ModelContainer(for: MovieDetails.self)
      let modelContext = ModelContext(modelContainer)
      let viewModelDependencies = ViewModelDependencies(apiClient: apiClient,
                                                        imageClient: imageClient,
                                                        imageCache: imageCache,
                                                        dataCache: dataCache,
                                                        apiKey: env.value(for: .tmdbApiKey),
                                                        language: env.language,
                                                        region: env.region,
                                                        context: modelContext)
      let viewModelFactory = ViewModelContainerFactory(domain: viewModelDependencies)
      return .init(
        apiClient: apiClient,
        imageClient: imageClient,
        imageCache: imageCache,
        dataCache: dataCache,
        container: modelContainer,
        modelContext: modelContext,
        viewModelFactory: viewModelFactory
      )
    } catch {
      fatalError("")
    }
  }
}
