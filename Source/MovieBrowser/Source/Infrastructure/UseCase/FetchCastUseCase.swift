//
//  FetchCastUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

final class FetchCastUseCase: FetchCastUseCaseProtocol {
  private let repository: MovieRepositoryProtocol
  private let adapter: CastAdapter

  init(repository: MovieRepositoryProtocol,
       adapter: CastAdapter = CastAdapter()) {
    self.repository = repository
    self.adapter = adapter
  }

  func execute(id: Int) async throws -> CastCatalogModel {
    let dto = try await repository.requestCredits(id: id)
    return adapter.adapt(dto: dto)
  }
}
