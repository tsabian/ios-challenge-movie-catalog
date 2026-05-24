//
//  URLSessionProtocol.swift
//  Core
//
//  Created by Tiago de Oliveira on 22/05/26.
//

import Foundation

public protocol URLSessionProtocol {
  func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
