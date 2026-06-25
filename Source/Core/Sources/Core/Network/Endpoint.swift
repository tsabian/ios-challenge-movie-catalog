//
//  Endpoint.swift
//  Core
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Foundation

public enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
  case patch = "PATCH"
}

public enum ContentType: String {
  case json = "application/json"
}

public protocol Endpoint: Sendable {
  var path: String { get }
  var method: HTTPMethod { get }
  var headers: [String: String]? { get }
  var queryItems: [URLQueryItem]? { get }
  var body: Data? { get }
  var acceptType: ContentType { get }
  var contentType: ContentType { get }
}

public extension Endpoint {
  var headers: [String: String]? {
    nil
  }

  var queryItems: [URLQueryItem]? {
    nil
  }

  var body: Data? {
    nil
  }

  var acceptType: ContentType {
    .json
  }

  var contentType: ContentType {
    .json
  }

  func createRequest(for host: String) async throws -> URLRequest {
    guard var components = URLComponents(string: host + path) else {
      throw URLError(.badURL)
    }
    components.queryItems = queryItems
    guard let url = components.url else {
      throw URLError(.badURL)
    }
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.setValue(acceptType.rawValue, forHTTPHeaderField: "Accept")
    request.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
    headers?.forEach { key, value in
      request.setValue(value, forHTTPHeaderField: key)
    }
    request.httpBody = body
    return request
  }
}
