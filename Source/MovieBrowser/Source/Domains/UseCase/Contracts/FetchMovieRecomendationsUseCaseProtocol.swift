//
//  FetchMovieRecomendationsUseCaseProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

protocol FetchMovieRecomendationsUseCaseProtocol {
  func execute(detail: MovieDetailsModel, page: Int) async throws -> MovieCatalogModel
}
