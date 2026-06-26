//
//  FetchGenreUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/06/26.
//

import Foundation

final class FetchGenreUseCase: FetchGenreUseCaseProtocol {
  private let repository: GenreRepositoryProtocol

  init(repository: GenreRepositoryProtocol) {
    self.repository = repository
  }

  func fetch() async throws -> [GenreModel] {
    try await repository.fetch()
  }
}
