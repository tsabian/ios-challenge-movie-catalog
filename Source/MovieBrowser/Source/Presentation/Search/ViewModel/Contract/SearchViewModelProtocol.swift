//
//  SearchViewModelProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 19/06/26.
//

import SwiftUI

protocol SearchViewModelProtocol: ObservableObject {
  var state: SearchState { get }
  var path: [SearchRouter] { get set }
  var page: Int { get set }

  func search(movie title: String) async
  func getGenreName(id: Int) async -> String
  func reset()
  func requestDetails(selectedMovie: SearchMovieResultModel)
}
