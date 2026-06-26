//
//  MovieDetailViewModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import Combine
import Core
import Foundation
import UIKit

enum MovieDetailState {
  case idle
  case loading
  case loaded(MovieDetailContentState)
  case error
}

@MainActor
final class MovieDetailViewModel: MovieDetailViewModelProtocol {
  @Published private(set) var state: MovieDetailState = .idle
  @Published private(set) var imagePreview: UIImage?
  @Published private(set) var isBookmark: Bool = false
  @Published var backdropPath: String?
  @Published var movieTitle: String

  private var detail: MovieDetailsModel?
  private var reviews = [UserReviewModel]()
  private var cast = [CastModel]()
  private var recommendations: MovieCatalogModel?
  private var watchProviders: WatchProviderResultModel?
  private var currentReviewsPage = 0
  private var totalReviewsPages = 1

  private let hostUrlString: String
  private let selectedMovie: MovieModel

  // MARK: - UseCases

  private let detailUseCase: FetchMovieDetailUseCaseProtocol
  private let reviewUseCase: FetchMovieReviewsUseCaseProtocol
  private let castUseCase: FetchCastUseCaseProtocol
  private let imageService: ImageLoadingServiceProtocol
  private let insertRemoveBookmarkUseCase: InsertOrRemoveBookmarkUseCaseProtocol
  private let recommendationsUseCase: FetchMovieRecommendationsUseCaseProtocol
  private let watchProviderUseCase: FetchWatchProviderUseCaseProtocol

  // MARK: - Computed

  private var isLoadingReviews: Bool = false {
    didSet {
      updateLoadState()
    }
  }

  private var isLoadingRecommendations: Bool = false {
    didSet {
      updateLoadState()
    }
  }

  private var isLoadingWatchProviders: Bool = false {
    didSet {
      updateLoadState()
    }
  }

  private var isLoadingCast: Bool = false {
    didSet {
      updateLoadState()
    }
  }

  private var canLoadMoreReviews: Bool = true {
    didSet {
      updateLoadState()
    }
  }

  init(dependencies: MovieDetailsViewModelDependencies) {
    selectedMovie = dependencies.selectedMovie
    detailUseCase = dependencies.detailUseCase
    reviewUseCase = dependencies.reviewUseCase
    castUseCase = dependencies.castUseCase
    imageService = dependencies.imageService
    insertRemoveBookmarkUseCase = dependencies.insertRemoveBookmarkUseCase
    watchProviderUseCase = dependencies.watchedProviderUseCase
    recommendationsUseCase = dependencies.recommendationsUseCase
    backdropPath = selectedMovie.backdropPath
    movieTitle = selectedMovie.title
    hostUrlString = dependencies.hostUrlString
  }

  func loadIfNeeded() async {
    guard case .idle = state else { return }

    state = .loading

    do {
      detail = try await detailUseCase.execute(movie: selectedMovie.id)
      isBookmark = detail?.isBookmark ?? false
      await makePosterPreview()
      updateLoadState()
    } catch {
      state = .error
    }
  }

  func makeMovieURL() -> URL? {
    guard let detail,
          let urlComponents = URLComponents(string: hostUrlString),
          let url = urlComponents.url?.appending(path: "movie").appending(path: "\(detail.id)") else {
      return nil
    }
    return url
  }

  func addOrRemoveWatchList() {
    guard let detail else { return }
    do {
      isBookmark = try insertRemoveBookmarkUseCase.execute(detail: detail)
    } catch {
      state = .error
    }
  }

  func loadReviewsIfNeeded() async {
    guard canLoadMoreReviews,
          !isLoadingReviews,
          currentReviewsPage < totalReviewsPages else {
      return
    }
    isLoadingReviews = true
    defer {
      isLoadingReviews = false
    }
    do {
      let nextPage = currentReviewsPage + 1
      let model = try await reviewUseCase.execute(movieID: selectedMovie.id,
                                                  page: nextPage)
      currentReviewsPage = nextPage
      totalReviewsPages = model.totalPages
      canLoadMoreReviews = currentReviewsPage < totalReviewsPages
      reviews.append(contentsOf: model.reviews)
    } catch UseCaseError.noMorePages {
      canLoadMoreReviews = false
    } catch {
      state = .error
    }
  }

  func loadCastIfNeeded() async {
    guard cast.isEmpty, !isLoadingCast else {
      return
    }
    isLoadingCast = true
    defer {
      isLoadingCast = false
    }
    do {
      let model = try await castUseCase.execute(id: selectedMovie.id)
      cast = model.cast
    } catch {
      state = .error
    }
  }

  func loadRecommendationsIfNeeded() async {
    guard !isLoadingRecommendations, recommendations == nil, let detail else {
      return
    }
    isLoadingRecommendations = true
    defer {
      isLoadingRecommendations = false
    }
    do {
      recommendations = try await recommendationsUseCase.execute(detail: detail, page: 1)
    } catch {
      state = .error
    }
  }

  func loadWatchProvidersIfNeeded() async {
    guard !isLoadingWatchProviders, watchProviders == nil, let detail else {
      return
    }
    isLoadingWatchProviders = true
    defer {
      isLoadingWatchProviders = false
    }
    do {
      watchProviders = try await watchProviderUseCase.execute(movie: detail)
    } catch {
      state = .error
    }
  }

  private func makePosterPreview() async {
    imagePreview = UIImage(named: "popcorn")
    guard let detail, let posterPath = detail.posterPath else {
      return
    }
    do {
      let image = try await imageService.fetchImage(from: posterPath,
                                                    withSize: .small)
      imagePreview = image.croppedToAspectRatio(ratio: 1)
    } catch {
      imagePreview = UIImage(named: "popcorn")
    }
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
                                   recommendations: recommendations,
                                   watchProviders: watchProviders,
                                   isLoadingReviewsNextPage: isLoadingReviews,
                                   isLoadingCast: isLoadingCast,
                                   isLoadingRecommendations: isLoadingRecommendations,
                                   isLoadingWatchProviders: isLoadingWatchProviders,
                                   canLoadMoreReviews: canLoadMoreReviews)
  }
}
