//
//  MovieDetailContainerBuilder.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import Core

struct MovieDetailBuilder {
  private let apiClient: ApiClientProtocol
  private let apiKey: String
  private let language: String?
  private let region: String?
  private let movie: MovieModel

  init(apiClient: ApiClientProtocol,
       apiKey: String,
       language: String?,
       region: String?,
       movie: MovieModel) {
    self.apiClient = apiClient
    self.apiKey = apiKey
    self.language = language
    self.region = region
    self.movie = movie
  }

  func build() -> MovieDetailViewModel {
    let repository = MovieRepository(apiClient: apiClient,
                                     apiKey: apiKey,
                                     language: language,
                                     region: region)
    let detailUseCase = FetchMovieDetailUseCase(repository: repository)
    let movieUseCase = FetchMovieReviewsUseCase(repository: repository)
    let castUseCase = FetchCastUseCase(repository: repository)
    return MovieDetailViewModel(selectedMovie: movie,
                                detailUseCase: detailUseCase,
                                reviewUseCase: movieUseCase,
                                castUseCase: castUseCase)
  }
}
