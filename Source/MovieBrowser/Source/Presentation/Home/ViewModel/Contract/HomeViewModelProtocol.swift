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
  var canLoadNextPage: Bool { get }
  var currentCategory: MovieCategory { get set }

  func load() async
  func fetch(category: MovieCategory) async
  func fetchNextPage(for category: MovieCategory) async
}
