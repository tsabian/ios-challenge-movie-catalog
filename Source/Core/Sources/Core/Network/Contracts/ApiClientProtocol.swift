//
//  ApiClientProtocol.swift
//  Core
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Foundation

public protocol ApiClientProtocol: Sendable {
  func execute(endpoint: Endpoint) async throws -> ApiClientResult
}
