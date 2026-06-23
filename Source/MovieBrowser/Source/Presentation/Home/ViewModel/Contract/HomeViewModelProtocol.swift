//
//  HomeViewModelProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import Combine

protocol HomeViewModelProtocol: ObservableObject {
  var state: HomeState { get }
  var isLoadingNextPage: Bool { get }
  var currentCategory: MovieCategory { get set }

  func load() async
  func select(category: MovieCategory) async
  func loadNextPage() async
}
