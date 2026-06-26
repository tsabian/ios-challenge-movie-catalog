//
//  RootViewModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 22/06/26.
//

import Combine

enum RootState: Equatable {
  case idle
  case loading
  case loaded
  case error(String)
}

@MainActor
final class RootViewModel: RootViewModelProtocol {
  @Published private(set) var state: RootState = .idle

  func startApp() async {
    state = .loading

    try? await Task.sleep(nanoseconds: 1_500_000_000)

    state = .loaded
  }
}
