//
//  FetchCastUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

final class FetchCastUseCase: FetchCastUseCaseProtocol {
  private let repository: MovieCreditsRepositoryProtocol

  init(repository: MovieCreditsRepositoryProtocol) {
    self.repository = repository
  }

  func execute(id: Int) async throws -> CastCatalogModel {
    try await repository.requestCredits(id: id)
  }
}
