//
//  WatchListDataSourceProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

@MainActor
protocol WatchListDataSourceProtocol {
  func getAll() throws -> [MovieDetails]
  func get(by id: Int) throws -> MovieDetails?
  func insert(movie: MovieDetails) throws
  func update(movie: MovieDetails, watched: Bool) throws
  func delete(movie: MovieDetails) throws
}
