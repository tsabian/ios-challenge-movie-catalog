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
  @Published var searchText: String = ""
  @Published var currentCategory: MovieCategory = .topRated

  func load() async {}
  func select(category _: MovieCategory) async {}
}
