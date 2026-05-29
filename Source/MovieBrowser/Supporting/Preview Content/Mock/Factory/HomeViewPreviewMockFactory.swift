//
//  HomeViewPreviewMockFactory.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import SwiftUI

enum HomeViewPreviewMockFactory {
  @MainActor
  static func make() -> HomeViewModelMock {
    HomeViewModelMock()
  }
}
