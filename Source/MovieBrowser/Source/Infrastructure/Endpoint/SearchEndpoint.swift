//
//  SearchEndpoint.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 19/06/26.
//

import Core
import Foundation

enum SearchApiRoute {
  case search
}

struct SearchEndpoint: Endpoint {
  let route: SearchApiRoute
  let query: String
  let includeAdult: Bool
  let apiKey: String
  let language: String?
  let region: String?
  let page: Int

  var path: String {
    switch route {
    case .search:
      "/3/search/movie"
    }
  }

  var method: HTTPMethod {
    .get
  }

  var queryItems: [URLQueryItem]? {
    [
      URLQueryItem(name: "api_key", value: apiKey),
      URLQueryItem(name: "language", value: language),
      URLQueryItem(name: "page", value: "\(page)"),
      URLQueryItem(name: "region", value: region),
      URLQueryItem(name: "include_adult", value: "\(includeAdult)"),
      URLQueryItem(name: "query", value: query)
    ]
  }
}
