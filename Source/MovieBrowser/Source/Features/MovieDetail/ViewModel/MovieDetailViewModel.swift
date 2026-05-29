//
//  MovieDetailViewModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import Combine

enum MovieDetailState {
  case idle
  case loading
  case loaded(detail: MovieDetailsModel)
  case reviews(reviews: [UserReviewModel])
  case error
  case empty
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
  @Published private(set) var state: MovieDetailState = .idle
  @Published var backdropPath: String

  private var currentPage = 0
  private var totalPages = 0
  private let detail: MovieDetailsModel
  private let reviewUseCase: FetchMovieReviewsUseCaseProtocol

  init(detail: MovieDetailsModel,
       reviewUseCase: FetchMovieReviewsUseCaseProtocol) {
    self.detail = detail
    backdropPath = detail.backdropPath
    self.reviewUseCase = reviewUseCase
  }

  func load() async {
    state = .loading
    state = .loaded(detail: detail)
  }

  func requestNextPage() {
    Task {
      await loadReviewsIfNeeded()
    }
  }

  private func loadReviewsIfNeeded() async {
    guard currentPage < totalPages else { return }
    currentPage += 1
    do {
      let model = try await reviewUseCase.execute(movieID: detail.id,
                                                  page: currentPage)
      totalPages = model.totalPages
      state = .reviews(reviews: model.reviews)
    } catch {
      state = .error
    }
  }
}
