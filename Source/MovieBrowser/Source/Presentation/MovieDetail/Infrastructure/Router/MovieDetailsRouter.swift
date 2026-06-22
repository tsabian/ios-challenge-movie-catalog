//
//  MovieDetailsRouter.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 22/06/26.
//

enum MovieDetailsFeatures {
  case watchList
}

enum MovieDetailsActions {
  case rate
}

final class MovieDetailsRouter: AppNavitagionRouterProtocol {
  var path: [MovieDetailsFeatures] = []

  func navigation(to feature: MovieDetailsFeatures) {
    path.append(feature)
  }
}
