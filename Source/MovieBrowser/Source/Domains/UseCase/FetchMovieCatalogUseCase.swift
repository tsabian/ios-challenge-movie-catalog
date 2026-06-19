//
//  FetchMovieCatalogUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 19/06/26.
//

final class FetchMovieCatalogUseCase: FetchMovieCatalogUseCaseProtocol {
  private let repository: MovieRepositoryProtocol

  init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }

  func fetch(by category: MovieCategory, page: Int = 1) async throws -> MovieCatalogModel {
    try await repository.fetchMovies(category: category, page: page)
  }
}
