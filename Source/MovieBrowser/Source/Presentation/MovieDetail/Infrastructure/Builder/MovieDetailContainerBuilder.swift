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
    let movieRepository = makeMovieRepository()
    let watchListRepository = makeWatchListRepository()

    let movieUseCase = FetchMovieReviewsUseCase(repository: movieRepository)
    let castUseCase = FetchCastUseCase(repository: movieRepository)
    let recommendationUseCase = FetchMovieRecommendationsUseCase(movieRepository: movieRepository)
    let watchProviderUseCase = FetchWatchProviderUseCase(repository: movieRepository)
    let detailUseCase = FetchMovieDetailUseCase(
      repository: movieRepository,
      watchListRepository: watchListRepository
    )
    let insertOrRemoveBookmarkUseCase = InsertOrRemoveBookmarkUseCase(
      watchListRepository: watchListRepository
    )

    return .init(
      selectedMovie: builderDependencies.movie,
      hostUrlString: builderDependencies.hostUrlString,
      detailUseCase: detailUseCase,
      reviewUseCase: movieUseCase,
      castUseCase: castUseCase,
      imageService: builderDependencies.imageService,
      insertRemoveBookmarkUseCase: insertOrRemoveBookmarkUseCase,
      recommendationsUseCase: recommendationUseCase,
      watchedProviderUseCase: watchProviderUseCase
    )
  }

  private func makeMovieRepository() -> MovieRepository {
    let dependencies = MovieRepositoryDependencies(
      apiKey: builderDependencies.apiKey,
      language: builderDependencies.language,
      region: builderDependencies.region,
      movieAdapter: .init(),
      detailAdapter: .init(),
      reviewAdapter: .init(),
      castAdapter: .init(),
      watchProvidersAdapter: .init()
    )
    return MovieRepository(apiClient: builderDependencies.apiClient,
                           dependencies: dependencies)
  }

  private func makeWatchListRepository() -> WatchListRepository {
    let dataSource = WatchListDataSource(context: context)
    return WatchListRepository(dataSource: dataSource)
  }
}
