//
//  FetchCastUseCaseProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

protocol FetchCastUseCaseProtocol {
  func execute(id: Int) async throws -> CastCatalogModel
}
