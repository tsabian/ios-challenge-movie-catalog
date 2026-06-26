//
//  WatchProviderResultModel+Stubs.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 24/06/26.
//

extension WatchProviderResultModel {
  static func mock(link: String = "https://www.google.com.br") -> Self {
    WatchProvidersModel
      .mock().results.first?.value ?? .init(
        link: link,
        flatrate: .flatrateMock(),
        rent: .rentMock(),
        buy: .buyMock(),
        free: .freeMock(),
        ads: .adsMock()
      )
  }
}
