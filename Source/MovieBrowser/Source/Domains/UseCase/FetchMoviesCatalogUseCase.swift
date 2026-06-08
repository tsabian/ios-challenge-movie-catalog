//
//  FetchMoviesCatalogUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

struct FetchMoviesCatalogUseCase: FetchMoviesCatalogUseCaseProtocol {
  private let repository: MovieRepositoryProtocol

  init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }

  func execute(category: MovieCategory, page: Int = 1) async throws -> HomeContentModel {
    let topRatedMovies = try await repository.fetchMovies(category: .topRated, page: 1)
    let catalog = try await repository.fetchMovies(
      category: category,
      page: category == .topRated ? page + 1 : page
    )
    return HomeContentModel(rankedMovies: topRatedMovies.movies, movies: catalog.movies)
  }
}
