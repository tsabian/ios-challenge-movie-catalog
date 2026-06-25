//
//  FetchMovieDetailUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

final class FetchMovieDetailUseCase: FetchMovieDetailUseCaseProtocol {
  private let repository: MovieRepositoryProtocol
  private let watchListRepository: WatchListRepositoryProtocol

  init(repository: MovieRepositoryProtocol,
       watchListRepository: WatchListRepositoryProtocol) {
    self.repository = repository
    self.watchListRepository = watchListRepository
  }

  func execute(movie id: Int) async throws -> MovieDetailsModel {
    var model = try await repository.requestDetail(id: id)
    if try watchListRepository.fetch(by: id) != nil {
      model.isBookmark = true
    }
    return model
  }
}
