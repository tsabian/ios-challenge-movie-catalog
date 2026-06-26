//
//  SearchRepositoryProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 19/06/26.
//

protocol SearchRepositoryProtocol {
  func find(query: String, page: Int) async throws -> SearchMovieCatalogModel
}
