//
//  GenreRepositoryProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/06/26.
//

protocol GenreRepositoryProtocol {
  func fetch() async throws -> [GenreModel]
}
