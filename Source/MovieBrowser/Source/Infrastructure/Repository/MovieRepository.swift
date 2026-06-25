//
//  MovieRepository.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Core
import Foundation

final class MovieRepository: MovieRepositoryProtocol {
  private let dependencies: MovieRepositoryDependencies
  private let decoder: JSONDecoder

  enum MovieRepositoryError: Error {
    case invalidRequest
    case invalidResponse(status: Int? = nil)
  }

  init(dependencies: MovieRepositoryDependencies,
       decoder: JSONDecoder = JSONDecoder()) {
    self.dependencies = dependencies
    self.decoder = decoder
    self.decoder.dateDecodingStrategy = .iso8601
  }

  func fetchMovies(category: MovieCategory, page: Int) async throws -> MovieCatalogModel {
    let data = try await dependencies.apiClient.execute(endpoint: makeCatalogEndpoint(category,
                                                                                      page: page))
    let dto = try decoder.decode(MovieCatalogDto.self, from: data)
    return dependencies.movieAdapter.adapt(dto: dto)
  }

  func requestDetail(id: Int) async throws -> MovieDetailsModel {
    let data = try await dependencies.apiClient.execute(endpoint: makeDetailEndpoint(id))
    let dto = try decoder.decode(MovieDetailDto.self, from: data)
    return dependencies.detailAdapter.adapt(dto: dto)
  }

  func requestReviews(id: Int, page: Int) async throws -> ReviewModel {
    let data = try await dependencies.apiClient.execute(endpoint: makeReviewsEndpoint(id, page))
    let dto = try decoder.decode(ReviewCatalogDto.self, from: data)
    return dependencies.reviewAdapter.adapt(dto: dto)
  }

  func requestCredits(id: Int) async throws -> CastCatalogModel {
    let data = try await dependencies.apiClient.execute(endpoint: makeCreditsEndpoint(id))
    let dto = try decoder.decode(CastingDto.self, from: data)
    return dependencies.castAdapter.adapt(dto: dto)
  }

  func requestRecomendations(id: Int, page: Int) async throws -> MovieCatalogModel {
    let recomendationEndpoint = makeRecomendationsEndpoint(id, page)
    let data = try await dependencies.apiClient.execute(endpoint: recomendationEndpoint)
    let dto = try decoder.decode(MovieCatalogDto.self, from: data)
    return dependencies.movieAdapter.adapt(dto: dto)
  }

  func requestProviders(id: Int) async throws -> WatchProvidersModel {
    let watchProvidersEndpoint = makeWatchProvidersEndpoint(id)
    let data = try await dependencies.apiClient.execute(endpoint: watchProvidersEndpoint)
    let dto = try decoder.decode(WatchProvidersDto.self, from: data)
    return dependencies.watchProvidersAdapter.adapt(dto: dto)
  }

  private func makeCatalogEndpoint(_ category: MovieCategory, page: Int) -> Endpoint {
    MovieEndpoint(route: MovieApiRoute(category: category),
                  apiKey: dependencies.apiKey,
                  language: dependencies.language,
                  region: dependencies.region,
                  page: page)
  }

  private func makeDetailEndpoint(_ id: Int) -> Endpoint {
    MovieEndpoint(route: .details(id: id),
                  apiKey: dependencies.apiKey,
                  language: dependencies.language,
                  region: dependencies.region,
                  page: nil)
  }

  private func makeReviewsEndpoint(_ id: Int, _ page: Int) -> Endpoint {
    MovieEndpoint(route: .reviews(id: id),
                  apiKey: dependencies.apiKey,
                  language: dependencies.language,
                  region: dependencies.region,
                  page: page)
  }

  private func makeCreditsEndpoint(_ id: Int) -> Endpoint {
    MovieEndpoint(
      route: .credits(id: id),
      apiKey: dependencies.apiKey,
      language: dependencies.language,
      region: dependencies.region,
      page: nil
    )
  }

  private func makeRecomendationsEndpoint(_ id: Int, _ page: Int) -> Endpoint {
    MovieEndpoint(
      route: .recomendations(id: id),
      apiKey: dependencies.apiKey,
      language: dependencies.language,
      region: dependencies.region,
      page: page
    )
  }

  private func makeWatchProvidersEndpoint(_ id: Int) -> Endpoint {
    MovieEndpoint(route: .watchProviders(id: id),
                  apiKey: dependencies.apiKey,
                  language: nil,
                  region: nil,
                  page: nil)
  }
}
