//
//  ResourceCacheProvider.swift
//  Core
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Foundation

public final class ResourceCacheProvider<T: AnyObject>: ResourceCacheProviderProtocol {
  private let cache: NSCache<NSString, T>

  public init(cache: NSCache<NSString, T>) {
    self.cache = cache
  }

  public func cache(object: T, for key: NSString) {
    cache.setObject(object, forKey: key)
  }

  public func getObject(forKey key: NSString) -> T? {
    cache.object(forKey: key)
  }

  public func remove(for key: NSString) {
    cache.removeObject(forKey: key)
  }
}
