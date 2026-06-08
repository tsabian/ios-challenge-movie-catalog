//
//  FetchMovieReviewsUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

final class FetchMovieReviewsUseCase: FetchMovieReviewsUseCaseProtocol {
  private let repository: MovieRepositoryProtocol

  init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }

  func execute(movieID: Int, page: Int) async throws -> ReviewModel {
    try await repository.requestReviews(id: movieID, page: page)
  }
}
