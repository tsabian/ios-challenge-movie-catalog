//
//  HomeViewModelMock.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Combine
import SwiftUI

final class HomeViewModelMock: HomeViewModelProtocol {
  @Published var state: HomeState = .idle
  @Published private(set) var isLoadingNextPage: Bool = false
  @Published var currentCategory: MovieCategory = .topRated
  @Published var canLoadNextPage: Bool = true

  func load() async {}
  func select(category _: MovieCategory) async {}

  func change(state: HomeState) -> Self {
    self.state = state
    return self
  }

  func fetchNextPage() async {
    isLoadingNextPage = true
  }
}
