//
//  RootViewModelMock.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 22/06/26.
//

import Combine

final class RootViewModelMock: RootViewModelProtocol {
  @Published var state: RootState = .loaded

  func startApp() async {}

  func updateState(with state: RootState) -> Self {
    self.state = state
    return self
  }
}
