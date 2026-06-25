//
//  MovieRepositoryProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Foundation

protocol MovieRepositoryProtocol {
  func fetchMovies(category: MovieCategory, page: Int) async throws -> MovieCatalogModel
  func requestDetail(id: Int) async throws -> MovieDetailsModel
  func requestReviews(id: Int, page: Int) async throws -> ReviewModel
  func requestCredits(id: Int) async throws -> CastCatalogModel
  func requestRecomendations(id: Int, page: Int) async throws -> MovieCatalogModel
  func requestProviders(id: Int) async throws -> WatchProvidersModel
}
