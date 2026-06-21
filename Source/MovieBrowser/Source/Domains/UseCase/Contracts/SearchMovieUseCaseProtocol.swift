//
//  SearchMovieUseCaseProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 19/06/26.
//

protocol SearchMovieUseCaseProtocol {
  func find(movie title: String, page: Int) async throws -> SearchMovieCatalogModel
}
