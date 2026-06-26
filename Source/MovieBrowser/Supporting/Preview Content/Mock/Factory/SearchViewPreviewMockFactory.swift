//
//  SearchViewPreviewMockFactory.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 19/06/26.
//

enum SearchViewPreviewMockFactory {
  @MainActor
  static func make() -> SearchViewModelMock {
    SearchViewModelMock()
  }
}
