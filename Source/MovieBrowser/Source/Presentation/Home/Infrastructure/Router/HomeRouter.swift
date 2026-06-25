//
//  HomeRouter.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import SwiftUI

enum HomeRouterFeatures: Hashable {
  case openDetails(movie: MovieModel)
}

@MainActor
@Observable
final class HomeRouter: AppNavitagionRouterProtocol {
  var path: [HomeRouterFeatures] = []

  func navigation(to feature: HomeRouterFeatures) {
    path.append(feature)
  }

  func popToRoot() {
    path.removeAll()
  }
}
