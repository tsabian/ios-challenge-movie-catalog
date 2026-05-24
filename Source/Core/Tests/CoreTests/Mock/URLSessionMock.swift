//
//  URLSessionMock.swift
//  Core
//
//  Created by Tiago de Oliveira on 22/05/26.
//

import Core
import Foundation

final class URLSessionMock: URLSessionProtocol {
  var dataResult: (Data, URLResponse)?
  var errorToThrow: Error?
  private(set) var dataCount = 0

  func data(for _: URLRequest) async throws -> (Data, URLResponse) {
    dataCount += 1

    if let errorToThrow {
      throw errorToThrow
    }

    return dataResult ?? (Data(), .stub())
  }
}
