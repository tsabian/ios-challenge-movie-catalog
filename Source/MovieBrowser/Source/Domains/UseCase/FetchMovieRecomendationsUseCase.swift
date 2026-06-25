//
//  FetchMovieRecomendationsUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

final class FetchMovieRecomendationsUse: FetchMovieRecomendationsUseCaseProtocol {
  private let movieRepository: MovieRepositoryProtocol

  init(movieRepository: MovieRepositoryProtocol) {
    self.movieRepository = movieRepository
  }

  func execute(detail: MovieDetailsModel, page: Int) async throws -> MovieCatalogModel {
    try await movieRepository.requestRecomendations(id: detail.id, page: page)
  }
}
