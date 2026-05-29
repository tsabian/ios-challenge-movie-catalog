//
//  RemotePosterContainerBuilder.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Core
import Foundation
import SwiftUI

struct RemotePosterContainerBuilder {
  private let apiClient: ApiClientProtocol
  private let cache: NSCache<NSString, UIImage>

  init(apiClient: ApiClientProtocol,
       cache: NSCache<NSString, UIImage>) {
    self.apiClient = apiClient
    self.cache = cache
  }

  func build() -> some RemotePosterViewModel {
    let provider = ResourceCacheProvider<UIImage>(cache: cache)
    let repository = RemotePosterRepository(apiClient: apiClient)
    let useCase = FetchRemoteImageUseCase(repository: repository,
                                          cache: provider)
    return RemotePosterViewModel(useCase: useCase)
  }
}
