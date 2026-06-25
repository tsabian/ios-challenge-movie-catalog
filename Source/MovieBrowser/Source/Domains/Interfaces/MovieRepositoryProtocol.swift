//
//  MovieRepositoryProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Foundation

typealias MovieRepositoryProtocol = MovieCatalogRepositoryProtocol &
  MovieCreditsRepositoryProtocol &
  MovieDetailsRepositoryProtocol &
  MovieProviderRepositoryProtocol &
  MovieRecomendationsRepositoryProtocol &
  MovieReviewsRepositoryProtocol

protocol MovieCatalogRepositoryProtocol: Sendable {
  func fetchMovies(category: MovieCategory, page: Int) async throws -> MovieCatalogModel
}

protocol MovieDetailsRepositoryProtocol {
  func requestDetail(id: Int) async throws -> MovieDetailsModel
}

protocol MovieReviewsRepositoryProtocol {
  func requestReviews(id: Int, page: Int) async throws -> ReviewModel
}

protocol MovieCreditsRepositoryProtocol {
  func requestCredits(id: Int) async throws -> CastCatalogModel
}

protocol MovieRecomendationsRepositoryProtocol {
  func requestRecomendations(id: Int, page: Int) async throws -> MovieCatalogModel
}

protocol MovieProviderRepositoryProtocol {
  func requestProviders(id: Int) async throws -> WatchProvidersModel
}
