//
//  WatchListDataSource.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

import Foundation
import SwiftData

@MainActor
final class WatchListDataSource: MovieDataStorage, WatchListDataSourceProtocol {
  func getAll() throws -> [MovieDetails] {
    let descriptor = FetchDescriptor<MovieDetails>()
    return try context.fetch(descriptor)
  }

  func get(by id: Int) throws -> MovieDetails? {
    let query = #Predicate<MovieDetails> { movie in
      movie.id == id
    }
    var descriptor = FetchDescriptor<MovieDetails>(predicate: query)
    descriptor.fetchLimit = 1
    return try context.fetch(descriptor).first
  }

  func insert(movie: MovieDetails) throws {
    context.insert(movie)
    try save()
  }

  func update(movie: MovieDetails, watched: Bool) throws {
    movie.watched = watched
    try save()
  }

  func delete(movie: MovieDetails) throws {
    context.delete(movie)
    try save()
  }

  private func hasMovieExists(_ movie: MovieDetails) throws -> Bool {
    try get(by: movie.id) != nil
  }
}
