//
//  MovieDetailContentState+Stub.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

extension MovieDetailContentState {
  static func mock(isLoadingReviews: Bool = false,
                   isLoadingCast: Bool = false,
                   isLoadingRecommendations: Bool = false,
                   isLoadingWatchProviders: Bool = false,
                   canLoadMoreReviews: Bool = true) -> Self {
    MovieDetailContentState(detail: .mock(),
                            reviews: ReviewModel.mock().reviews,
                            cast: .mock(),
                            recommendations: .mock(),
                            watchProviders: .mock(),
                            isLoadingReviewsNextPage: isLoadingReviews,
                            isLoadingCast: isLoadingCast,
                            isLoadingRecommendations: isLoadingRecommendations,
                            isLoadingWatchProviders: isLoadingWatchProviders,
                            canLoadMoreReviews: canLoadMoreReviews)
  }
}
