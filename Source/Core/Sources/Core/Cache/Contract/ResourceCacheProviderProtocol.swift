//
//  ResourceCacheProviderProtocol.swift
//  Core
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Foundation

public protocol ResourceCacheProviderProtocol {
  associatedtype CacheType: AnyObject

  func cache(object: CacheType, for key: NSString)
  func getObject(forKey key: NSString) -> CacheType?
  func remove(for key: NSString)
}
