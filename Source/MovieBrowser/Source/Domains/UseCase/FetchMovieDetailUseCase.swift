//
//  FetchMovieDetailUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

final class FetchMovieDetailUseCase: FetchMovieDetailUseCaseProtocol {
  private let repository: MovieRepositoryProtocol
  private let adapter: DetailAdapter

  init(repository: MovieRepositoryProtocol,
       adapter: DetailAdapter = DetailAdapter()) {
    self.repository = repository
    self.adapter = adapter
  }

  func execute(movie id: Int) async throws -> MovieDetailsModel {
    let dto = try await repository.requestDetail(id: id)
    return adapter.adapt(dto: dto)
  }
}
