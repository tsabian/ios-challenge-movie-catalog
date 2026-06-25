//
//  FetchWatchProviderUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

import Foundation

final class FetchWatchProviderUseCase: FetchWatchProviderUseCaseProtocol {
  private let repository: MovieProviderRepositoryProtocol
  private let locale: Locale

  init(repository: MovieProviderRepositoryProtocol,
       locale: Locale = .current) {
    self.repository = repository
    self.locale = locale
  }

  func execute(movie: MovieDetailsModel) async throws -> WatchProviderResultModel? {
    let model = try await repository.requestProviders(id: movie.id)
    let region = locale.region?.identifier ?? "US"
    return model.results[region]
  }
}
