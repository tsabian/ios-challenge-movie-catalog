//
//  MovieDetailContentState.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

struct MovieDetailContentState {
  let detail: MovieDetailsModel
  var reviews: [UserReviewModel]
  var cast: [CastModel]
  var recommendations: MovieCatalogModel?
  var watchProviders: WatchProviderResultModel?
  var isLoadingReviewsNextPage: Bool
  var isLoadingCast: Bool
  var isLoadingRecommendations: Bool
  var isLoadingWatchProviders: Bool
  var canLoadMoreReviews: Bool
}
