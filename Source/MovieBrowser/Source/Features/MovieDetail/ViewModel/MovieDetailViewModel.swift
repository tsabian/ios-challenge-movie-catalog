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
  case loaded(MovieDetailContentState)
  case error
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
  @Published private(set) var state: MovieDetailState = .idle
  @Published var backdropPath: String

  private var reviews = [UserReviewModel]()
  private var cast = [CastModel]()
  private var currentPage = 0
  private var totalPages: Int?

  private let reviewUseCase: FetchMovieReviewsUseCaseProtocol
  private let castUseCase: FetchCastUseCaseProtocol

  private let detail: MovieDetailsModel

  private var canLoadMoreReviews: Bool {
    guard let totalPages else { return true }
    return currentPage < totalPages
  }

  init(detail: MovieDetailsModel,
       reviewUseCase: FetchMovieReviewsUseCaseProtocol,
       castUseCase: FetchCastUseCaseProtocol) {
    self.detail = detail
    backdropPath = detail.backdropPath
    self.reviewUseCase = reviewUseCase
    self.castUseCase = castUseCase
  }

  func load() async {
    state = .loaded(makeContentState())
  }

  func requestNextPage() {
    Task {
      await loadReviewsIfNeeded()
    }
  }

  func requestCast() {
    Task {
      await loadCastIfNeeded()
    }
  }

  private func loadReviewsIfNeeded() async {
    guard canLoadMoreReviews else { return }

    state = .loaded(makeContentState(isLoadingReviews: true))

    do {
      let nextPage = currentPage + 1
      let model = try await reviewUseCase.execute(movieID: detail.id,
                                                  page: nextPage)
      currentPage = nextPage
      totalPages = model.totalPages
      reviews.append(contentsOf: model.reviews)

      state = .loaded(makeContentState())
    } catch {
      state = .loaded(makeContentState())
    }
  }

  private func loadCastIfNeeded() async {
    guard cast.isEmpty else { return }

    state = .loaded(makeContentState(isLoadingCast: true))

    do {
      let model = try await castUseCase.execute(id: detail.id)
      cast = model.cast
      state = .loaded(makeContentState())
    } catch {
      state = .loaded(makeContentState())
    }
  }

  private func makeContentState(isLoadingReviews: Bool = false,
                                isLoadingCast: Bool = false) -> MovieDetailContentState {
    MovieDetailContentState(detail: detail,
                            reviews: reviews,
                            cast: cast,
                            isLoadingReviews: isLoadingReviews,
                            isLoadingCast: isLoadingCast,
                            canLoadMoreReviews: canLoadMoreReviews)
  }
}
