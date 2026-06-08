//
//  FetchMovieDetailUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

final class FetchMovieDetailUseCase: FetchMovieDetailUseCaseProtocol {
  private let repository: MovieRepositoryProtocol

  init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }

  func execute(movie id: Int) async throws -> MovieDetailsModel {
    try await repository.requestDetail(id: id)
  }
}
