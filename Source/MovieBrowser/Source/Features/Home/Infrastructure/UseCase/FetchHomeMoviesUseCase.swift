//
//  FetchHomeMoviesUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

struct FetchHomeMoviesUseCase: FetchHomeMoviesUseCaseProtocol {
  private let adapter: MovieAdapter
  private let repository: MovieRepositoryProtocol

  init(adapter: MovieAdapter = MovieAdapter(),
       repository: MovieRepositoryProtocol) {
    self.adapter = adapter
    self.repository = repository
  }

  func execute(category: MovieCategory, page: Int = 1) async throws -> HomeContent {
    let topRatedMovies = try await repository.fetchMovies(category: .topRated, page: 1)
    let catalog = try await repository.fetchMovies(
      category: category,
      page: category == .topRated ? page + 1 : page
    )
    let rankedMovies = adapter.adapt(dto: topRatedMovies.results)
    let movies = adapter.adapt(dto: catalog.results)
    return HomeContent(rankedMovies: rankedMovies, movies: movies)
  }
}
