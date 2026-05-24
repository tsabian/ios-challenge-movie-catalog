//
//  ApiClient.swift
//  Core
//
//  Created by Tiago de Oliveira on 22/05/26.
//

import Foundation

public typealias ApiClientResult = (data: Data?, response: URLResponse)

public final class ApiClient {
  private let session: URLSessionProtocol

  public init(session: URLSessionProtocol = URLSession.shared) {
    self.session = session
  }

  public func execute(request: URLRequest) async -> Result<ApiClientResult, Error> {
    do {
      let result = try await session.data(for: request)
      return .success(result)
    } catch {
      return .failure(error as NSError)
    }
  }
}
