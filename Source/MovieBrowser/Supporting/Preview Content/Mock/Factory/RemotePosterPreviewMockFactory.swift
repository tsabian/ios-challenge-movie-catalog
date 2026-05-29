//
//  RemotePosterPreviewMockFactory.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import SwiftUI

enum RemotePosterPreviewMockFactory {
  @MainActor
  static func make(state: RemotePosterState) -> some RemotePosterViewModelProtocol {
    let viewModel = RemotePosterViewModelMock()
    viewModel.state = state
    return viewModel
  }
}
