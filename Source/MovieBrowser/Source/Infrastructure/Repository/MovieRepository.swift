//
//  MovieRepository.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Core
import Foundation

final class MovieRepository: NetworkRepository, MovieRepositoryProtocol {
  private let dependencies: MovieRepositoryDependencies

  init(apiClient: ApiClientProtocol,
       decoder: JSONDecoder = .init(),
       dependencies: MovieRepositoryDependencies) {
    self.dependencies = dependencies
    super.init(apiClient: apiClient, decoder: decoder, dateDecodingStrategy: .iso8601)
  }

  func fetchMovies(category: MovieCategory, page: Int) async throws -> MovieCatalogModel {
    try await request(endpoint: makeCatalogEndpoint(category, page: page),
                      decode: MovieCatalogDto.self) { dto in
      dependencies.movieAdapter.adapt(dto: dto)
    }
  }

  func requestDetail(id: Int) async throws -> MovieDetailsModel {
    try await request(endpoint: makeDetailEndpoint(id),
                      decode: MovieDetailDto.self) { dto in
      dependencies.detailAdapter.adapt(dto: dto)
    }
  }

  func requestReviews(id: Int, page: Int) async throws -> ReviewModel {
    try await request(endpoint: makeReviewsEndpoint(id, page),
                      decode: ReviewCatalogDto.self) { dto in
      dependencies.reviewAdapter.adapt(dto: dto)
    }
  }

  func requestCredits(id: Int) async throws -> CastCatalogModel {
    try await request(endpoint: makeCreditsEndpoint(id),
                      decode: CastingDto.self) { dto in
      dependencies.castAdapter.adapt(dto: dto)
    }
  }

  func requestRecomendations(id: Int, page: Int) async throws -> MovieCatalogModel {
    try await request(endpoint: makeRecomendationsEndpoint(id, page),
                      decode: MovieCatalogDto.self) { dto in
      dependencies.movieAdapter.adapt(dto: dto)
    }
  }

  func requestProviders(id: Int) async throws -> WatchProvidersModel {
    try await request(endpoint: makeWatchProvidersEndpoint(id),
                      decode: WatchProvidersDto.self) { dto in
      dependencies.watchProvidersAdapter.adapt(dto: dto)
    }
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
