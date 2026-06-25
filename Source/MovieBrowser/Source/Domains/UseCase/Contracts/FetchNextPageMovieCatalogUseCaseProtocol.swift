//
//  FetchNextPageMovieCatalogUseCaseProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 19/06/26.
//

protocol FetchNextPageMovieCatalogUseCaseProtocol {
  func execute(by category: MovieCategory,
               content: inout HomeContentModel) async throws
}
