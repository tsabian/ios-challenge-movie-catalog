//
//  MovieDetailsViewModelDependencies.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

struct MovieDetailsViewModelDependencies {
  let selectedMovie: MovieModel
  let hostUrlString: String
  let detailUseCase: FetchMovieDetailUseCaseProtocol
  let reviewUseCase: FetchMovieReviewsUseCaseProtocol
  let castUseCase: FetchCastUseCaseProtocol
  let imageService: ImageLoadingServiceProtocol
  let insertRemoveBookmarkUseCase: InsertOrRemoveBookmarkUseCaseProtocol
  let recomendationsUseCase: FetchMovieRecomendationsUseCaseProtocol
  let watchedProviderUseCase: FetchWatchProviderUseCaseProtocol
}
