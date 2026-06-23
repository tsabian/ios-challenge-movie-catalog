//
//  MovieDetailViewModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import Combine
import Core
import Foundation
import SwiftUI

enum MovieDetailState {
  case idle
  case loading
  case loaded(MovieDetailContentState)
  case error
}

@MainActor
final class MovieDetailViewModel: MovieDetailViewModelProtocol {
  @Published private(set) var state: MovieDetailState = .idle
  @Published var backdropPath: String?
  @Published var movieTitle: String
  @Published private(set) var imagePreview: Image?

  private var detail: MovieDetailsModel?
  private var reviews = [UserReviewModel]()
  private var cast = [CastModel]()
  private var currentPage = 0
  private var totalPages: Int?
  private var isLoadingReviews: Bool = false {
    didSet {
      updateLoadState()
    }
  }

  private var isLoadingCast: Bool = false {
    didSet {
      updateLoadState()
    }
  }

  private let detailUseCase: FetchMovieDetailUseCaseProtocol
  private let reviewUseCase: FetchMovieReviewsUseCaseProtocol
  private let castUseCase: FetchCastUseCaseProtocol
  private let imageService: ImageLoadingServiceProtocol

  private let selectedMovie: MovieModel

  private var canLoadMoreReviews: Bool {
    guard let totalPages else { return true }
    return currentPage < totalPages
  }

  init(selectedMovie: MovieModel,
       detailUseCase: FetchMovieDetailUseCaseProtocol,
       reviewUseCase: FetchMovieReviewsUseCaseProtocol,
       castUseCase: FetchCastUseCaseProtocol,
       imageService: ImageLoadingServiceProtocol) {
    self.selectedMovie = selectedMovie
    self.detailUseCase = detailUseCase
    self.reviewUseCase = reviewUseCase
    self.castUseCase = castUseCase
    self.imageService = imageService
    backdropPath = selectedMovie.backdropPath
    movieTitle = selectedMovie.title
  }

  func loadIfNeeded() async {
    guard case .idle = state else { return }

    state = .loading

    do {
      detail = try await detailUseCase.execute(movie: selectedMovie.id)
      await makePosterPreview()
      updateLoadState()
    } catch {
      state = .error
    }
  }

  func requestNextPageForReviews() {
    Task {
      await loadReviewsIfNeeded()
    }
  }

  func requestCast() {
    Task {
      await loadCastIfNeeded()
    }
  }

  func makeMovieURL() -> URL? {
    let sourceUrlString = AppEnvironment.current.value(for: .tmdbHost)
    guard let detail,
          let urlComponents = URLComponents(string: sourceUrlString),
          let url = urlComponents.url?.appending(path: "movie").appending(path: "\(detail.id)") else {
      return nil
    }
    return url
  }

  private func makePosterPreview() async {
    imagePreview = Image("popcorn")
    guard let detail, let posterPath = detail.posterPath else {
      return
    }
    do {
      let image = try await imageService.fetchImage(from: posterPath,
                                                    withSize: .small)
      let croppedImage = image.croppedToAspectRatio(ratio: 1)
      imagePreview = Image(uiImage: croppedImage)
    } catch {
      debugPrint(error)
    }
  }

  private func loadReviewsIfNeeded() async {
    guard canLoadMoreReviews, !isLoadingReviews else {
      return
    }

    isLoadingReviews = true

    do {
      let nextPage = currentPage + 1
      let model = try await reviewUseCase.execute(movieID: selectedMovie.id,
                                                  page: nextPage)
      currentPage = nextPage
      totalPages = model.totalPages
      reviews.append(contentsOf: model.reviews)
    } catch {
      state = .error
    }
    isLoadingReviews = false
  }

  private func loadCastIfNeeded() async {
    guard cast.isEmpty, !isLoadingCast else {
      return
    }

    isLoadingCast = true

    do {
      let model = try await castUseCase.execute(id: selectedMovie.id)
      cast = model.cast
    } catch {
      state = .error
    }
    isLoadingCast = false
  }

  private func updateLoadState() {
    guard let contentState = makeContentState() else {
      state = .error
      return
    }
    state = .loaded(contentState)
  }

  private func makeContentState() -> MovieDetailContentState? {
    guard let detail else { return nil }
    return MovieDetailContentState(detail: detail,
                                   reviews: reviews,
                                   cast: cast,
                                   isLoadingReviews: isLoadingReviews,
                                   isLoadingCast: isLoadingCast,
                                   canLoadMoreReviews: canLoadMoreReviews)
  }
}
