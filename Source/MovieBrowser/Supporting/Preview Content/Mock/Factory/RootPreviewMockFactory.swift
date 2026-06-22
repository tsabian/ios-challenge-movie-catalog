//
//  RootPreviewMockFactory.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 22/06/26.
//

enum RootPreviewMockFactory {
  @MainActor
  static func make() -> RootViewModelMock {
    RootViewModelMock()
  }
}
