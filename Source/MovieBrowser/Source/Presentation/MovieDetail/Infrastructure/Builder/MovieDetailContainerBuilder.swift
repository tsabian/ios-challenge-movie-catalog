//
//  MovieDetailContainerBuilder.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import Core
import Foundation
import SwiftData
import SwiftUI

struct MovieDetailBuilder {
  private let builderDependencies: MovieDetailBuilderDependencies
  private let context: ModelContext

  init(builderDependencies: MovieDetailBuilderDependencies,
       context: ModelContext) {
    self.builderDependencies = builderDependencies
    self.context = context
  }

  func build() -> MovieDetailViewModel {
    let dependencies = MovieRepositoryDependencies(
      apiClient: builderDependencies.apiClient,
      apiKey: builderDependencies.apiKey,
      language: builderDependencies.language,
      region: builderDependencies.region,
      movieAdapter: .init(),
      detailAdapter: .init(),
      reviewAdapter: .init(),
      castAdapter: .init()
    )
    let repository = MovieRepository(dependencies: dependencies)
    let detailUseCase = FetchMovieDetailUseCase(repository: repository)
    let movieUseCase = FetchMovieReviewsUseCase(repository: repository)
    let castUseCase = FetchCastUseCase(repository: repository)
    return MovieDetailViewModel(selectedMovie: builderDependencies.movie,
                                detailUseCase: detailUseCase,
                                reviewUseCase: movieUseCase,
                                castUseCase: castUseCase,
                                imageService: makeImageService(),
                                watchListRepository: makeWatchListRepository())
  }

  private func makeImageService() -> ImageLoadingServiceProtocol {
    let repository = RemotePosterRepository(apiClient: builderDependencies.imageClient)
    return ImageLoadingService(repository: repository, cache: builderDependencies.provider)
  }

  private func makeWatchListRepository() -> WatchListRepository {
    let dataSource = WatchListDataSource(context: context)
    return WatchListRepository(dataSource: dataSource)
  }
}
