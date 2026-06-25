//
//  FetchMovieReviewsUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

struct FetchMovieReviewsUseCase: FetchMovieReviewsUseCaseProtocol {
  private let repository: MovieReviewsRepositoryProtocol

  init(repository: MovieReviewsRepositoryProtocol) {
    self.repository = repository
  }

  func execute(movieID: Int, page: Int) async throws -> ReviewModel {
    try await repository.requestReviews(id: movieID, page: page)
  }
}
