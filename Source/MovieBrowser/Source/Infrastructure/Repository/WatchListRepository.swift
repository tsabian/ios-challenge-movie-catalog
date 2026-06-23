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

  func fetchWatchList() -> [MovieDetailsModel] {
    let entities = dataSource.getAll()
    return entities.compactMap(adapter.adapt(entity:))
  }

  func fetch(by id: Int) -> MovieDetailsModel? {
    guard let entity = dataSource.get(by: id) else {
      return nil
    }
    return adapter.adapt(entity: entity)
  }

  func insert(movie: MovieDetailsModel) {
    dataSource.insert(movie: adapter.reverse(model: movie))
  }

  func update(by id: Int, watched: Bool) {
    guard var entity = dataSource.get(by: id) else {
      return
    }
    dataSource.update(movie: entity, watched: watched)
  }

  func delete(by id: Int) {
    guard var entity = dataSource.get(by: id) else {
      return
    }
    dataSource.delete(movie: entity)
  }
}
