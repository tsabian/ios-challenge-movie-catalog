//
//  MovieDetailViewModelProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import SwiftUI

@MainActor
protocol MovieDetailViewModelProtocol: ObservableObject {
  var state: MovieDetailState { get }
  var backdropPath: String { get }

  func load() async
  func requestNextPage()
  func requestCast()
}
