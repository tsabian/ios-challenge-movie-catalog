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

  enum ApiClientSpyEndpoint: String, Endpoint {
    case fetch = "/request/v1/endpoint"

    var baseURL: String {
      "https://example.com"
    }

    var path: String {
      rawValue
    }

    var method: Core.HTTPMethod {
      .get
    }
  }

  init() async throws {
    sut = ApiClient(session: urlSessionMock)
  }

  @Test
  func executeTest() async {
    urlSessionMock.dataResult = (Data(), .stub())
    do {
      let result = try await sut.execute(endpoint: ApiClientSpyEndpoint.fetch)
      #expect(result.data.isEmpty, "Data should be Empty")
      #expect(result.response is HTTPURLResponse, "Response should be HTTPURLResponse")
      #expect((result.response as? HTTPURLResponse)?.statusCode ?? 200 >= 100, "Should be a valid response")
      #expect(urlSessionMock.dataCount == 1, "Expect only one call to session")
    } catch {
      Issue.record("Expected success but got failure: \(error)")
    }
  }

  @Test
  func executeWhenHasThrow() async {
    urlSessionMock.errorToThrow = NSError(domain: "throw", code: -1)
    do {
      _ = try await sut.execute(endpoint: ApiClientSpyEndpoint.fetch)
      Issue.record("Expected failure but got success")
    } catch {
      #expect(urlSessionMock.dataCount == 1, "Expect only one call to session")
      #expect(error.localizedDescription.contains("throw"))
    }
  }
}
