//
//  FetchHomeMovieUseCaseMock.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

final class FetchHomeMovieUseCaseMock: FetchHomeContentUseCaseProtocol {
  var result: HomeContentModel = .init(rankedMovies: [],
                                       movieCatalog: [.nowPlaying: .mock()])
  func execute(category _: MovieCategory) async throws -> HomeContentModel {
    result
  }
}
