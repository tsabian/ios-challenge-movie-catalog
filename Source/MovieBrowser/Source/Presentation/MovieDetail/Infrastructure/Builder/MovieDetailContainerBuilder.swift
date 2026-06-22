//
//  MovieDetailContainerBuilder.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import Core
import Foundation
import SwiftUI

struct MovieDetailBuilder {
  private let builderDependencies: MovieDetailBuilderDependencies

  init(builderDependencies: MovieDetailBuilderDependencies) {
    self.builderDependencies = builderDependencies
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
                                imageService: makeImageService())
  }

  private func makeImageService() -> ImageLoadingServiceProtocol {
    let repository = RemotePosterRepository(apiClient: builderDependencies.apiClient)
    return ImageLoadingService(repository: repository, cache: builderDependencies.provider)
  }
}
