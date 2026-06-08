//
//  MovieRepository.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Core
import Foundation

final class MovieRepository: MovieRepositoryProtocol {
  private let apiClient: ApiClientProtocol
  private let decoder: JSONDecoder
  private let apiKey: String
  private let language: String?
  private let region: String?

  enum MovieRepositoryError: Error {
    case invalidRequest
    case invalidResponse(status: Int? = nil)
  }

  init(apiClient: ApiClientProtocol,
       apiKey: String,
       language: String?,
       region: String?,
       decoder: JSONDecoder = JSONDecoder()) {
    self.apiClient = apiClient
    self.decoder = decoder
    self.apiKey = apiKey
    self.language = language
    self.region = region
  }

  func fetchMovies(category: MovieCategory, page: Int) async throws -> MovieCatalogModel {
    let data = try await apiClient.execute(endpoint: makeCatalogEndpoint(category,
                                                                         page: page))
    let dto = try decoder.decode(MovieCatalogDto.self, from: data)
    let adapter = MovieAdapter()
    return adapter.adapt(dto: dto)
  }

  func requestDetail(id: Int) async throws -> MovieDetailsModel {
    let data = try await apiClient.execute(endpoint: makeDetailEndpoint(id))
    let dto = try decoder.decode(MovieDetailDto.self, from: data)
    let adapter = DetailAdapter()
    return adapter.adapt(dto: dto)
  }

  func requestReviews(id: Int, page: Int) async throws -> ReviewModel {
    let data = try await apiClient.execute(endpoint: makeReviewsEndpoint(id, page))
    let dto = try decoder.decode(ReviewCatalogDto.self, from: data)
    let adapter = ReviewAdapter()
    return adapter.adapt(dto: dto)
  }

  func requestCredits(id: Int) async throws -> CastCatalogModel {
    let data = try await apiClient.execute(endpoint: makeCreditsEndpoint(id))
    let dto = try decoder.decode(CastingDto.self, from: data)
    let adapter = CastAdapter()
    return adapter.adapt(dto: dto)
  }

  private func makeCatalogEndpoint(_ category: MovieCategory, page: Int) -> Endpoint {
    MovieEndpoint(route: MovieApiRoute(category: category),
                  apiKey: apiKey,
                  language: language,
                  region: region,
                  page: page)
  }

  private func makeDetailEndpoint(_ id: Int) -> Endpoint {
    MovieEndpoint(route: .details(id: id),
                  apiKey: apiKey,
                  language: language,
                  region: region,
                  page: nil)
  }

  private func makeReviewsEndpoint(_ id: Int, _ page: Int) -> Endpoint {
    MovieEndpoint(route: .reviews(id: id),
                  apiKey: apiKey,
                  language: language,
                  region: region,
                  page: page)
  }

  private func makeCreditsEndpoint(_ id: Int) -> Endpoint {
    MovieEndpoint(
      route: .credits(id: id),
      apiKey: apiKey,
      language: language,
      region: region,
      page: nil
    )
  }
}
