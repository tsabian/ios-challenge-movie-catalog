//
//  ViewModelContainerFactory.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 28/05/26.
//

import Core
import Foundation
import SwiftData

struct ViewModelDependencies {
  let apiClient: ApiClientProtocol
  let dataCache: NSCache<NSString, NSData>
  let imageLoadingService: ImageLoadingServiceProtocol
  let apiKey: String
  let language: String?
  let region: String?
  let context: ModelContext
  let hostURLString: String
}

struct ViewModelContainerFactory {
  private let domain: ViewModelDependencies

  var imageLoadingService: ImageLoadingServiceProtocol {
    domain.imageLoadingService
  }

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

  func makeMovieDetail(movie: MovieModel) -> MovieDetailViewModel {
    let dependencies = MovieDetailBuilderDependencies(apiClient: domain.apiClient,
                                                      apiKey: domain.apiKey,
                                                      language: domain.language,
                                                      region: domain.region,
                                                      movie: movie,
                                                      imageService: domain.imageLoadingService,
                                                      hostUrlString: domain.hostURLString)
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
