//
//  HomeEndpoint.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Core
import Foundation

enum HomeApiRoute {
  case topRated
  case popular
  case upComing
  case nowPlaying

  init(category: MovieCategory) {
    switch category {
    case .topRated:
      self = .topRated
    case .popular:
      self = .popular
    case .upComing:
      self = .upComing
    case .nowPlaying:
      self = .nowPlaying
    }
  }
}

struct HomeEndpoint: Endpoint {
  let route: HomeApiRoute
  let apiKey: String
  let language: String?
  let region: String?
  let page: Int

  var path: String {
    switch route {
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

  var queryItems: [URLQueryItem]? {
    [
      URLQueryItem(name: "language", value: language),
      URLQueryItem(name: "page", value: "\(page)"),
      URLQueryItem(name: "region", value: region),
      URLQueryItem(name: "api_key", value: apiKey)
    ]
  }
}
