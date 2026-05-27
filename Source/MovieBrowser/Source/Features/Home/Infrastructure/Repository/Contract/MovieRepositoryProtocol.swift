//
//  MovieRepositoryProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Foundation

protocol MovieRepositoryProtocol {
  func fetchMovies(service: HomeService) async throws -> MovieCatalogDto
}
