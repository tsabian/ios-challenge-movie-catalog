//
//  EventsContainer.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 26/05/26.
//

import SwiftUI

extension EnvironmentValues {
  @Entry var onMovieSelectAction: ((HomeMovieModel) -> Void)?
  @Entry var onMovieShareAction: ((HomeMovieModel) -> Void)?
  @Entry var onCategorySelectAction: ((MovieCategory) -> Void)?
  @Entry var onTextChangeAction: ((String) -> Void)?
  @Entry var onTextClearAction: (() -> Void)?
  @Entry var onSearchAction: ((String) -> Void)?
}
