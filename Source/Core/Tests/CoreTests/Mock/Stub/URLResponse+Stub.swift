//
//  URLResponse+Stub.swift
//  Core
//
//  Created by Tiago de Oliveira on 22/05/26.
//

import Foundation

extension URLResponse {
  static func stub(url: URL = .stub(),
                   statusCode: Int = 200,
                   headers: [String: String]? = nil) -> URLResponse
  {
    HTTPURLResponse(url: url,
                    statusCode: statusCode,
                    httpVersion: nil,
                    headerFields: headers) ?? URLResponse()
  }
}
