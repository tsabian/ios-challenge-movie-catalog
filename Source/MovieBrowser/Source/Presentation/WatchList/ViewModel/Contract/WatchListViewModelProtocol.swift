//
//  WatchListViewModelProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

import Combine

protocol WatchListViewModelProtocol: ObservableObject {
  var state: WathcListState { get }

  func loadIfNeeded()
  func makeMovie(from model: MovieDetailsModel) -> MovieModel
}
