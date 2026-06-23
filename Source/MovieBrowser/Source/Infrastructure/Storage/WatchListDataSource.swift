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
  func getAll() -> [MovieDetails] {
    let descriptor = FetchDescriptor<MovieDetails>()
    do {
      return try context.fetch(descriptor)
    } catch {
      return []
    }
  }

  func get(by id: Int) -> MovieDetails? {
    let query = #Predicate<MovieDetails> { movie in
      movie.id == id
    }
    var descriptor = FetchDescriptor<MovieDetails>(predicate: query)
    descriptor.fetchLimit = 1
    do {
      return try context.fetch(descriptor).first
    } catch {
      return nil
    }
  }

  func insert(movie: MovieDetails) {
    context.insert(movie)
    save()
  }

  func update(movie: MovieDetails, watched: Bool) {
    movie.watched = watched
    save()
  }

  func delete(movie: MovieDetails) {
    context.delete(movie)
    save()
  }

  private func hasMovieExists(_ movie: MovieDetails) -> Bool {
    get(by: movie.id) != nil
  }
}
