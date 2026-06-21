//
//  GenreEndpoint.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/06/26.
//

import Core
import Foundation

struct GenreEndpoint: Endpoint {
  let apiKey: String
  let language: String?

  var path: String {
    "/genre/movie/list"
  }

  var method: HTTPMethod {
    .get
  }

  var queryItems: [URLQueryItem]? {
    [
      URLQueryItem(name: "api_key", value: apiKey),
      URLQueryItem(name: "language", value: language ?? "")
    ]
  }
}
