//
//  ViewModelContainerFactory.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 28/05/26.
//

import Core
import Foundation
import SwiftData
import SwiftUI

struct ViewModelDependencies {
  let apiClient: ApiClientProtocol
  let imageClient: ApiClientProtocol
  let imageCache: NSCache<NSString, UIImage>
  let dataCache: NSCache<NSString, NSData>
  let apiKey: String
  let language: String?
  let region: String?
  let context: ModelContext
}

struct ViewModelContainerFactory {
  private let domain: ViewModelDependencies

  init(domain: ViewModelDependencies) {
    self.domain = domain
  }

  func makeRoot() -> RootViewModel {
    RootBuilder().build()
  }

  func makeHome() -> HomeViewModel {
    let builder = HomeContainerBuilder(apiClient: domain.apiClient,
                                       apiKey: domain.apiKey,
                                       language: domain.language,
                                       region: domain.region)
    return builder.build()
  }

  func makeSearch() -> SearchViewModel {
    let builder = SearchMovieBuilder(apiClient: domain.apiClient,
                                     apiKey: domain.apiKey,
                                     language: domain.language,
                                     region: domain.region,
                                     dataCache: domain.dataCache)
    return builder.build()
  }

  func makeRemotePoster() -> RemotePosterViewModel {
    let builder = RemotePosterContainerBuilder(apiClient: domain.imageClient,
                                               cache: domain.imageCache)
    return builder.build()
  }

  func makeMovieDetail(movie: MovieModel) -> MovieDetailViewModel {
    let provider = ResourceCacheProvider(cache: domain.imageCache)
    let dependencies = MovieDetailBuilderDependencies(apiClient: domain.apiClient,
                                                      imageClient: domain.imageClient,
                                                      apiKey: domain.apiKey,
                                                      language: domain.language,
                                                      region: domain.region,
                                                      movie: movie,
                                                      provider: provider)
    let builder = MovieDetailBuilder(builderDependencies: dependencies,
                                     context: domain.context)
    return builder.build()
  }

  func makeWatchList() -> WatchListViewModel {
    let dataSource = WatchListDataSource(context: domain.context)
    let repository = WatchListRepository(dataSource: dataSource)
    let builder = WatchListBuilder(repository: repository)
    return builder.build()
  }
}
