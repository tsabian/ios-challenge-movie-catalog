//
//  HomeViewModelProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

protocol HomeViewModelProtocol: ObservableObject {
  var state: HomeState { get }
  var path: [HomeRouter] { get set }
  var searchText: String { get set }
  var currentCategory: MovieCategory { get set }

  func load() async
  func select(category: MovieCategory) async
  func requestDetail(movie: MovieModel)
}
