//
//  URLRequest+Stub.swift
//  Core
//
//  Created by Tiago de Oliveira on 22/05/26.
//

import Foundation

extension URLRequest {
  static func stub(url: URL = .stub()) -> URLRequest {
    URLRequest(url: url)
  }
}
