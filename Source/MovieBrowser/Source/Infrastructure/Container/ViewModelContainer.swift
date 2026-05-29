//
//  ViewModelContainer.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 28/05/26.
//

import Core
import Foundation
import SwiftUI

struct ViewModelContainerFactory {
  private let apiClient: ApiClientProtocol
  private let imageClient: ApiClientProtocol
  private let imageCache: NSCache<NSString, UIImage>

  init(apiClient: ApiClientProtocol,
       imageClient: ApiClientProtocol,
       imageCache: NSCache<NSString, UIImage>) {
    self.apiClient = apiClient
    self.imageClient = imageClient
    self.imageCache = imageCache
  }

  func makeHome() -> HomeViewModel {
    let env = AppEnvironment.current.self
    let builder = HomeContainerBuilder(apiClient: apiClient,
                                       apiKey: env.value(for: .tmdbApiKey),
                                       language: env.language,
                                       region: env.region)
    return builder.build()
  }

  func makeRemotePoster() -> RemotePosterViewModel {
    let builder = RemotePosterContainerBuilder(apiClient: imageClient,
                                               cache: imageCache)
    return builder.build()
  }
}
