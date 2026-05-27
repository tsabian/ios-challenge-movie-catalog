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
    let topRatedMovies = try await repository.fetchMovies(service: .topRated(page: page))
    let catalog = try await repository.fetchMovies(
      service: makeCatalogService(from: category, with: page)
    )
    let rankedMovies = adapter.adapt(dto: topRatedMovies.results, for: .topRated)
    let movies = adapter.adapt(dto: catalog.results, for: category)
    return HomeContent(rankedMovies: rankedMovies, movies: movies)
  }

  private func makeCatalogService(from movieCategory: MovieCategory, with page: Int) -> HomeService {
    switch movieCategory {
    case .topRated:
      .topRated(page: page)
    case .popular:
      .popular(page: page)
    case .nowPlaying:
      .nowPlaying(page: page)
    case .upComing:
      .upComing(page: page)
    }
  }
}
