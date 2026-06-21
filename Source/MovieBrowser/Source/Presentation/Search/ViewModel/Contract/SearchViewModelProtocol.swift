//
//  SearchViewModelProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 19/06/26.
//

import SwiftUI

protocol SearchViewModelProtocol: ObservableObject {
  var state: SearchState { get }
  var page: Int { get set }
  var isLoadingNextPage: Bool { get }

  func search(movie title: String) async
  func loadNextPage() async
  func getGenreName(id: Int) -> String
  func reset()
  func makeMovieModel(from movie: SearchMovieResultModel) -> MovieModel
}
