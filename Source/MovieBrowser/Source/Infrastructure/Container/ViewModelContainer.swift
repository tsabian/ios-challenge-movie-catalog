//
//  ViewModelContainer.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 28/05/26.
//

import Core
import Foundation
import SwiftUI

struct ViewModelDependencies {
  let apiClient: ApiClientProtocol
  let imageClient: ApiClientProtocol
  let imageCache: NSCache<NSString, UIImage>
  let apiKey: String
  let language: String?
  let region: String?
}

struct ViewModelContainerFactory {
  private let domain: ViewModelDependencies

  init(domain: ViewModelDependencies) {
    self.domain = domain
  }

  func makeHome() -> HomeViewModel {
    let builder = HomeContainerBuilder(apiClient: domain.apiClient,
                                       apiKey: domain.apiKey,
                                       language: domain.language,
                                       region: domain.region)
    return builder.build()
  }

  func makeRemotePoster() -> RemotePosterViewModel {
    let builder = RemotePosterContainerBuilder(apiClient: domain.imageClient,
                                               cache: domain.imageCache)
    return builder.build()
  }
}
