//
//  ApiClientTests.swift
//  Core
//
//  Created by Tiago de Oliveira on 22/05/26.
//

@testable import Core
import Foundation
import Testing

struct ApiClientTests {
  private let sut: ApiClient
  private var urlSessionMock = URLSessionMock()

  init() async throws {
    sut = ApiClient(session: urlSessionMock)
  }

  @Test
  func executeTest() async {
    urlSessionMock.dataResult = (Data(), .stub())
    let result = await sut.execute(request: .stub())
    switch result {
    case let .success(result):
      #expect(result.data != nil, "Data should be nil")
      #expect(result.response is HTTPURLResponse, "Response should be HTTPURLResponse")
      #expect((result.response as? HTTPURLResponse)?.statusCode ?? 200 >= 100, "Should be a valid response")
      #expect(urlSessionMock.dataCount == 1, "Expect only one call to session")
    case let .failure(error):
      Issue.record("Expected success but got failure: \(error)")
    }
  }

  @Test
  func executeWhenHasThrow() async {
    urlSessionMock.errorToThrow = NSError(domain: "throw", code: -1)
    let result = await sut.execute(request: .stub())
    switch result {
    case .success:
      Issue.record("Expected failure but got success")
    case let .failure(error):
      #expect(urlSessionMock.dataCount == 1, "Expect only one call to session")
      #expect(error.localizedDescription.contains("throw"))
    }
  }
}
