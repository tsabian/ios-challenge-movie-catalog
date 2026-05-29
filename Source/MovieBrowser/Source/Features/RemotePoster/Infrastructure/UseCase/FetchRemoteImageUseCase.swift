//
//  FetchRemoteImageUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Core
import Foundation
import SwiftUI

final class FetchRemoteImageUseCase: FetchRemoteImageUseCaseProtocol {
  private let repository: RemotePosterRepositoryProtocol
  private let cache: ResourceCacheProvider<UIImage>

  enum RemoteImageError: Error {
    case invalidImageData
  }

  init(repository: RemotePosterRepositoryProtocol,
       cache: ResourceCacheProvider<UIImage>) {
    self.repository = repository
    self.cache = cache
  }

  func fetchImage(from pathURLString: String, withSize size: TMDBImageSize) async throws -> UIImage {
    let cacheKey = cacheKey(path: pathURLString, size: size)
    if let cachedImage = cache.getObject(forKey: cacheKey) {
      return cachedImage
    }
    let data = try await repository.fetch(path: pathURLString, size: .originalBig)
    guard let uiImage = UIImage(data: data) else {
      throw RemoteImageError.invalidImageData
    }
    cache.cache(object: uiImage, for: cacheKey)
    return uiImage
  }

  private func cacheKey(path: String, size: TMDBImageSize) -> NSString {
    NSString(string: "\(size.rawValue):\(path)")
  }
}
