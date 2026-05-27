//
//  HomeService.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Core
import Foundation

enum HomeService: Endpoint {
  case topRated(page: Int)
  case popular(page: Int)
  case upComing(page: Int)
  case nowPlaying(page: Int)

  var baseURL: String {
    AppEnvironment.current.value(for: .tmdbApiBaseUrl)
  }

  var path: String {
    switch self {
    case .topRated:
      "/movie/top_rated"
    case .popular:
      "/movie/popular"
    case .upComing:
      "/movie/upcoming"
    case .nowPlaying:
      "/movie/now_playing"
    }
  }

  var method: HTTPMethod {
    .get
  }

  private var page: Int {
    switch self {
    case let .topRated(page),
         let .popular(page),
         let .upComing(page),
         let .nowPlaying(page):
      page
    }
  }

  var queryItems: [URLQueryItem]? {
    let env = AppEnvironment.current.self
    return [
      URLQueryItem(name: "language", value: env.language),
      URLQueryItem(name: "page", value: "\(page)"),
      URLQueryItem(name: "region", value: env.region),
      URLQueryItem(name: "api_key", value: env.value(for: .tmdbApiKey))
    ]
  }
}
