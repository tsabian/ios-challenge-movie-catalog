//
//  SearchRouter.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/06/26.
//

import SwiftUI

enum SearchRouterFeatures: Hashable {
  case openDetails(movie: MovieModel)
}

@MainActor
@Observable
final class SearchRouter: AppNavitagionRouterProtocol {
  var path: [SearchRouterFeatures] = []

  func navigation(to feature: SearchRouterFeatures) {
    path.append(feature)
  }
}
