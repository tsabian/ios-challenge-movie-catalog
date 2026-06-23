//
//  WatchListRouter.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

import SwiftUI

enum WatchListFeatures: Hashable {
  case openDetails(movie: MovieDetailsModel)
}

@MainActor
@Observable
final class WatchListRouter: AppNavitagionRouterProtocol {
  var path: [WatchListFeatures] = []

  func navigation(to feature: WatchListFeatures) {
    path.append(feature)
  }
}
