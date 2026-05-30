//
//  FetchMovieReviewsUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

final class FetchMovieReviewsUseCase: FetchMovieReviewsUseCaseProtocol {
  private let repository: MovieRepositoryProtocol
  private let adapter: ReviewAdapter

  init(repository: MovieRepositoryProtocol,
       adapter: ReviewAdapter = ReviewAdapter()) {
    self.repository = repository
    self.adapter = adapter
  }

  func execute(movieID: Int, page: Int) async throws -> ReviewModel {
    let dto = try await repository.requestReviews(id: movieID, page: page)
    return adapter.adapt(dto: dto)
  }
}
