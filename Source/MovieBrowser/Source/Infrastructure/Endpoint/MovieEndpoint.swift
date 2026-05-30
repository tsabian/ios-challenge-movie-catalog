//
//  MovieEndpoint.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Core
import Foundation

enum MovieApiRoute {
  case topRated
  case popular
  case upComing
  case nowPlaying
  case details(id: Int)
  case reviews(id: Int)
  case credits(id: Int)

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

struct MovieEndpoint: Endpoint {
  let route: MovieApiRoute
  let apiKey: String
  let language: String?
  let region: String?
  let page: Int?

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
    case let .details(id):
      "/movie/\(id)"
    case let .reviews(id):
      "/movie/\(id)/reviews"
    case let .credits(id):
      "/movie/\(id)/credits"
    }
  }

  var method: HTTPMethod {
    .get
  }

  var queryItems: [URLQueryItem]? {
    var items = [
      URLQueryItem(name: "language", value: language),
      URLQueryItem(name: "region", value: region),
      URLQueryItem(name: "api_key", value: apiKey)
    ]
    if let page {
      items.append(URLQueryItem(name: "page", value: "\(page)"))
    }
    return items
  }
}
