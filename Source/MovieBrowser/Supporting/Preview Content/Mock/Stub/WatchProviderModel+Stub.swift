//
//  WatchProviderModel+Stub.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 24/06/26.
//

extension [WatchProviderModel] {
  static func flatrateMock() -> Self {
    WatchProvidersModel.mock()
      .results
      .first?.value.flatrate ?? []
  }

  static func adsMock() -> Self {
    WatchProvidersModel.mock()
      .results
      .first?.value.ads ?? []
  }

  static func buyMock() -> Self {
    WatchProvidersModel.mock()
      .results
      .first?.value.buy ?? []
  }

  static func freeMock() -> Self {
    WatchProvidersModel.mock()
      .results
      .first?.value.free ?? []
  }

  static func rentMock() -> Self {
    WatchProvidersModel.mock()
      .results
      .first?.value.rent ?? []
  }
}
