//
//  FetchHomeContentUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

struct FetchHomeContentUseCase: FetchHomeContentUseCaseProtocol {
  private let repository: MovieCatalogRepositoryProtocol

  init(repository: MovieCatalogRepositoryProtocol) {
    self.repository = repository
  }

  func execute(category: MovieCategory) async throws -> HomeContentModel {
    async let ranked = repository.fetchMovies(category: .topRated, page: 1)
    async let catalog = repository.fetchMovies(category: category, page: 1)
    let rankedResult = try await ranked
    let catalogResult = try await catalog
    return HomeContentModel(
      rankedMovies: rankedResult.movies,
      movieCatalog: [category: catalogResult]
    )
  }
}
