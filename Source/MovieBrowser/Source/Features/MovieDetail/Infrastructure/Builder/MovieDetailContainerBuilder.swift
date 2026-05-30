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
  private let detail: MovieDetailsModel

  init(apiClient: ApiClientProtocol,
       apiKey: String,
       language: String?,
       region: String?,
       detail: MovieDetailsModel) {
    self.apiClient = apiClient
    self.apiKey = apiKey
    self.language = language
    self.region = region
    self.detail = detail
  }

  func build() -> MovieDetailViewModel {
    let repository = MovieRepository(apiClient: apiClient,
                                     apiKey: apiKey,
                                     language: language,
                                     region: region)
    let movieUseCase = FetchMovieReviewsUseCase(repository: repository)
    let castUseCase = FetchCastUseCase(repository: repository)
    return MovieDetailViewModel(detail: detail,
                                reviewUseCase: movieUseCase,
                                castUseCase: castUseCase)
  }
}
