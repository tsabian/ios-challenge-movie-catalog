//
//  FetchMovieCatalogUseCaseProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 19/06/26.
//

protocol FetchMovieCatalogUseCaseProtocol {
  func fetch(by category: MovieCategory, page: Int) async throws -> MovieCatalogModel
}
