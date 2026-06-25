//
//  FetchMovieRecomendationsUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

final class FetchMovieRecomendationsUse: FetchMovieRecomendationsUseCaseProtocol {
  private let movieRepository: MovieRecomendationsRepositoryProtocol
  private var currentPage = 0
  private var totalPages = 0

  init(movieRepository: MovieRecomendationsRepositoryProtocol) {
    self.movieRepository = movieRepository
  }

  func execute(detail: MovieDetailsModel) async throws -> MovieCatalogModel {
    let nextPage = currentPage + 1
    debugPrint("Current Page: \(currentPage), Next page \(nextPage) of \(totalPages)")
    let model = try await movieRepository.requestRecomendations(id: detail.id,
                                                                page: nextPage)
    currentPage = nextPage
    totalPages = model.totalPages
    return model
  }
}
