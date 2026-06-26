//
//  MovieDetailPreviewMockFactory.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import SwiftUI

@MainActor
enum MovieDetailPreviewMockFactory {
  static func make(state: MovieDetailState) -> MovieDetailViewModelMock {
    let viewModel = MovieDetailViewModelMock()
    viewModel.state = state
    return viewModel
  }
}
