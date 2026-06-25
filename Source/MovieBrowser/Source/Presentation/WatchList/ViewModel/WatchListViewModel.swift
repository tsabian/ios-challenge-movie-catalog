//
//  WatchListViewModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

import Combine

enum WatchListState {
  case idle
  case loading
  case loaded(content: [MovieDetailsModel])
  case empty
  case error
}

final class WatchListViewModel: WatchListViewModelProtocol {
  @Published private(set) var state: WatchListState = .idle

  private let repository: WatchListRepositoryProtocol

  init(repository: WatchListRepositoryProtocol) {
    self.repository = repository
  }

  func loadIfNeeded() {
    state = .loading
    do {
      let content = try repository.fetchWatchList()
      state = content.isEmpty ? .empty : .loaded(content: content)
    } catch {
      state = .error
    }
  }

  func makeMovie(from model: MovieDetailsModel) -> MovieModel {
    MovieModel(id: model.id, title: model.title,
               posterPath: model.posterPath,
               backdropPath: model.backdropPath, rank: 0)
  }
}
