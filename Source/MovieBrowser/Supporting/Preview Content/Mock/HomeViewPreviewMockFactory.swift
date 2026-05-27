//
//  HomeViewPreviewMockFactory.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import SwiftUI

enum HomeViewPreviewMockFactory {
  @MainActor
  static func makeViewModelMock(state: HomeState) -> HomeViewModelMock {
    let viewModel = HomeViewModelMock()
    viewModel.state = state
    return viewModel
  }
}
