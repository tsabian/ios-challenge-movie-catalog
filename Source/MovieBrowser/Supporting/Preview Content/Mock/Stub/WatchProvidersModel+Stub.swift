//
//  WatchProvidersModel+Stub.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 24/06/26.
//

extension WatchProvidersModel {
  static func mock() -> Self {
    do {
      let dto = try PreviewDataFactory.shared.makeWatchProvider()
      return WatchProviderAdapter().adapt(dto: dto)
    } catch {
      fatalError()
    }
  }
}
