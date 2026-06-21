//
//  SearchMovieUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 19/06/26.
//

import Foundation

final class SearchMovieUseCase: SearchMovieUseCaseProtocol {
  private let repository: SearchRepositoryProtocol

  init(repository: SearchRepositoryProtocol) {
    self.repository = repository
  }

  func find(movie title: String, page: Int) async throws -> SearchMovieCatalogModel {
    try await repository.find(query: title, page: page)
  }
}
