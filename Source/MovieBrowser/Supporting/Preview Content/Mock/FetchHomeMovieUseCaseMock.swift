//
//  FetchHomeMovieUseCaseMock.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

final class FetchHomeMovieUseCaseMock: FetchMoviesCatalogUseCaseProtocol {
  var result: HomeContentModel = .init(rankedMovies: [], movies: [])
  func execute(category _: MovieCategory, page _: Int) async throws -> HomeContentModel {
    result
  }
}
