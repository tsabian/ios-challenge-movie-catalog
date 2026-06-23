//
//  WatchListDataSourceProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

@MainActor
protocol WatchListDataSourceProtocol {
  func getAll() -> [MovieDetails]
  func get(by id: Int) -> MovieDetails?
  func insert(movie: MovieDetails)
  func update(movie: MovieDetails, watched: Bool)
  func delete(movie: MovieDetails)
}
