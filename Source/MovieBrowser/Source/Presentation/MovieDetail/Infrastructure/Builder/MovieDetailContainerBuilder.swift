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
    .init(dependencies: makeViewModelDependencies())
  }

  private func makeViewModelDependencies() -> MovieDetailsViewModelDependencies {
    let repository = MovieRepository(dependencies: makeMovieRepository())
    let watchListRepository = makeWatchListRepository()
    let movieUseCase = FetchMovieReviewsUseCase(repository: repository)
    let castUseCase = FetchCastUseCase(repository: repository)
    let detailUseCase = FetchMovieDetailUseCase(
      repository: repository,
      watchListRepository: watchListRepository
    )
    let insertOrRemoveBookmarkUseCase = InsertOrRemoveBookmarkUseCase(
      watchListRepository: watchListRepository
    )
    let recomendationUseCase = FetchMovieRecomendationsUse(movieRepository: repository)
    let watchProviderUseCase = FetchWatchProviderUseCase(repository: repository)
    return .init(
      selectedMovie: builderDependencies.movie,
      detailUseCase: detailUseCase,
      reviewUseCase: movieUseCase,
      castUseCase: castUseCase,
      imageService: makeImageService(),
      insertRemoveBookmarkUseCase: insertOrRemoveBookmarkUseCase,
      recomendationsUseCase: recomendationUseCase,
      watchedProviderUseCase: watchProviderUseCase
    )
  }

  private func makeMovieRepository() -> MovieRepositoryDependencies {
    .init(
      apiClient: builderDependencies.apiClient,
      apiKey: builderDependencies.apiKey,
      language: builderDependencies.language,
      region: builderDependencies.region,
      movieAdapter: .init(),
      detailAdapter: .init(),
      reviewAdapter: .init(),
      castAdapter: .init(),
      watchProvidersAdapter: .init()
    )
  }

  private func makeImageService() -> ImageLoadingServiceProtocol {
    let repository = RemotePosterRepository(apiClient: builderDependencies.imageClient)
    return ImageLoadingService(repository: repository,
                               cache: builderDependencies.provider)
  }

  private func makeWatchListRepository() -> WatchListRepository {
    let dataSource = WatchListDataSource(context: context)
    return WatchListRepository(dataSource: dataSource)
  }
}
