//
//  RemotePosterEndpoint.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Core

enum RemotePosterServiceApiRoute {
  case fetch(path: String, size: TMDBImageSize)
}

struct RemotePosterEndpoint: Endpoint {
  let route: RemotePosterServiceApiRoute

  var path: String {
    switch route {
    case let .fetch(imageName, size):
      "/t/p/\(size.rawValue)\(imageName)"
    }
  }

  var method: HTTPMethod {
    .get
  }
}
