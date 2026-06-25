//
//  FetchNextPageMovieCatalogUseCaseProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 19/06/26.
//

protocol FetchNextPageMovieCatalogUseCaseProtocol {
  func execute(by category: MovieCategory, currentPage page: Int,
               totalPages: Int) async throws -> MovieCatalogModel
}
