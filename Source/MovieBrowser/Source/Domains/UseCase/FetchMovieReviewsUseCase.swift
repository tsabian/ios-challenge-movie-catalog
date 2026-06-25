//
//  FetchMovieReviewsUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

final class FetchMovieReviewsUseCase: FetchMovieReviewsUseCaseProtocol {
  private let repository: MovieReviewsRepositoryProtocol
  private var currentPage = 0
  private var totalPages = 0

  init(repository: MovieReviewsRepositoryProtocol) {
    self.repository = repository
  }

  func execute(movieID: Int) async throws -> ReviewModel {
    guard currentPage < totalPages else {
      throw UseCaseError.noMorePages
    }
    let nextPage = currentPage + 1
    debugPrint("Current Page: \(currentPage), Next page \(nextPage) of \(totalPages)")
    let model = try await repository.requestReviews(id: movieID, page: nextPage)
    currentPage = nextPage
    totalPages = model.totalPages
    return model
  }
}
