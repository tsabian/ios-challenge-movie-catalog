//
//  WatchListBuilder.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

struct WatchListBuilder {
  let repository: WatchListRepositoryProtocol

  func build() -> WatchListViewModel {
    WatchListViewModel(repository: repository)
  }
}
