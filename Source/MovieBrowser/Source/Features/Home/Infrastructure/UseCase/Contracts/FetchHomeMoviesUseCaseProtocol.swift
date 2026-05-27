//
//  FetchHomeMoviesUseCaseProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

protocol FetchHomeMoviesUseCaseProtocol {
  func execute(category: MovieCategory, page: Int) async throws -> HomeContent
}
