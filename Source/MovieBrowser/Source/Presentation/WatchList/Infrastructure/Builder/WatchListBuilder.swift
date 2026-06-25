//
//  WatchListBuilder.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

struct WatchListBuilder {
  private let repository: WatchListRepositoryProtocol

  init(repository: WatchListRepositoryProtocol) {
    self.repository = repository
  }

  func build() -> WatchListViewModel {
    WatchListViewModel(repository: repository)
  }
}
