//
//  AppContainer.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Core
import Foundation
import SwiftData
import UIKit

@MainActor
struct AppContainer {
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
    imageCache.countLimit = 150
    let dataCache = NSCache<NSString, NSData>()
    dataCache.countLimit = 20
    let imageProvider = ResourceCacheProvider<UIImage>(cache: imageCache)
    let imageRepository = RemotePosterRepository(apiClient: imageClient)
    let imageLoadingService = ImageLoadingService(repository: imageRepository,
                                                  cache: imageProvider)
    do {
      let modelContainer = try ModelContainer(for: MovieDetails.self)
      let modelContext = ModelContext(modelContainer)
      let viewModelDependencies = ViewModelDependencies(
        apiClient: apiClient,
        dataCache: dataCache,
        imageLoadingService: imageLoadingService,
        apiKey: env.value(for: .tmdbApiKey),
        language: env.language,
        region: env.region,
        context: modelContext,
        hostURLString: env.value(for: .tmdbHost)
      )
      let viewModelFactory = ViewModelContainerFactory(domain: viewModelDependencies)
      return .init(
        container: modelContainer,
        modelContext: modelContext,
        viewModelFactory: viewModelFactory
      )
    } catch {
      fatalError("Failed to create SwiftData ModelContainer: \(error)")
    }
  }
}
