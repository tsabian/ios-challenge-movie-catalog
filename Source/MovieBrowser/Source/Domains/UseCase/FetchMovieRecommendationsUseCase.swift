//
//  FetchMovieRecommendationsUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

struct FetchMovieRecommendationsUseCase: FetchMovieRecommendationsUseCaseProtocol {
  private let movieRepository: MovieRecommendationsRepositoryProtocol

  init(movieRepository: MovieRecommendationsRepositoryProtocol) {
    self.movieRepository = movieRepository
  }

  func execute(detail: MovieDetailsModel, page: Int) async throws -> MovieCatalogModel {
    try await movieRepository.requestRecommendations(id: detail.id, page: page)
  }
}
