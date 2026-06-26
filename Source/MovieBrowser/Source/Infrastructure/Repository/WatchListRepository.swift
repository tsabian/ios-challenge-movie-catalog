//
//  WatchListRepository.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

final class WatchListRepository: WatchListRepositoryProtocol {
  private let dataSource: WatchListDataSourceProtocol
  private let adapter: WatchingListAdapter

  init(dataSource: WatchListDataSourceProtocol,
       adapter: WatchingListAdapter = WatchingListAdapter()) {
    self.dataSource = dataSource
    self.adapter = adapter
  }

  func fetchWatchList() throws -> [MovieDetailsModel] {
    let entities = try dataSource.getAll()
    return entities.compactMap(adapter.adapt(entity:))
  }

  func fetch(by id: Int) throws -> MovieDetailsModel? {
    guard let entity = try dataSource.get(by: id) else {
      return nil
    }
    return adapter.adapt(entity: entity)
  }

  func addBookmark(movie: MovieDetailsModel) throws {
    try dataSource.insert(movie: adapter.reverse(model: movie))
  }

  func deleteBookmark(movie: MovieDetailsModel) throws {
    guard let entity = try dataSource.get(by: movie.id) else {
      return
    }
    try dataSource.delete(movie: entity)
  }

  func markAsWatched(movie: MovieDetailsModel) throws {
    guard let entity = try dataSource.get(by: movie.id) else {
      return
    }
    try dataSource.update(movie: entity, watched: true)
  }

  func markAsUnwatched(movie: MovieDetailsModel) throws {
    guard let entity = try dataSource.get(by: movie.id) else {
      return
    }
    try dataSource.update(movie: entity, watched: false)
  }
}
