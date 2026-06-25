//
//  FetchNextPageMovieCatalogUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 19/06/26.
//

final class FetchNextPageMovieCatalogUseCase: FetchNextPageMovieCatalogUseCaseProtocol {
  private let repository: MovieCatalogRepositoryProtocol

  init(repository: MovieCatalogRepositoryProtocol) {
    self.repository = repository
  }

  func execute(by category: MovieCategory, currentPage page: Int,
               totalPages: Int) async throws -> MovieCatalogModel {
    guard page < totalPages else {
      throw UseCaseError.noMorePages
    }
    let nextPage = page + 1
    debugPrint("Current Page: \(page), Next page \(nextPage) of \(totalPages)")
    return try await repository.fetchMovies(category: category, page: nextPage)
  }
}
