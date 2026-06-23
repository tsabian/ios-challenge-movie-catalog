//
//  WatchListRepositoryProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

protocol WatchListRepositoryProtocol {
  func fetchWatchList() -> [MovieDetailsModel]
  func fetch(by id: Int) -> MovieDetailsModel?
  func insert(movie: MovieDetailsModel)
  func update(by id: Int, watched: Bool)
  func delete(by id: Int)
}
