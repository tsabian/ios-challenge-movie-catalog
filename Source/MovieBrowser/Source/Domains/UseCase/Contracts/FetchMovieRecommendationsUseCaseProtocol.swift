//
//  FetchMovieRecommendationsUseCaseProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

protocol FetchMovieRecommendationsUseCaseProtocol {
  func execute(detail: MovieDetailsModel, page: Int) async throws -> MovieCatalogModel
}
