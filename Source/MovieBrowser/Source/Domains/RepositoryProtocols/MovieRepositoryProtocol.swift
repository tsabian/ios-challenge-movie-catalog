//
//  MovieRepositoryProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Foundation

protocol MovieRepositoryProtocol {
  func fetchMovies(category: MovieCategory, page: Int) async throws -> MovieCatalogDto
  func requestDetail(id: Int) async throws -> MovieDetailDto
  func requestReviews(id: Int, page: Int) async throws -> ReviewCatalogDto
  func requestCredits(id: Int) async throws -> CastingDto
}
