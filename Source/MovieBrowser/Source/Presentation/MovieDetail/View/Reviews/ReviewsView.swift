//
//  ReviewsView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import SwiftUI

struct ReviewsView: View {
  @Environment(\.appContainer) private var appContainer

  var isLoading: Bool
  var reviews: [UserReviewModel]
  let loadNextPage: () async -> Void

  var body: some View {
    if !isLoading, reviews.isEmpty {
      AlternativeFlowStateView(title: String(localized: .thereIsNoReviewYet),
                               message: String(localized: .noResultsMessage))
    } else {
      content
    }
  }

  private var content: some View {
    VStack(spacing: 12) {
      ForEach(reviews, id: \.id) { review in
        reviewRow(review)
          .onAppear {
            loadNextPageIfNeeded(review)
          }
        Divider()
      }
      if isLoading {
        LoadingView()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }
  }

  private func reviewRow(_ review: UserReviewModel) -> some View {
    HStack(alignment: .top, spacing: 12) {
      VStack(spacing: 24) {
        if let avatar = review.avatarPath {
          RemotePosterView(
            viewModel: appContainer.viewModelFactory.makeRemotePoster(),
            pathURLString: avatar)
            .clipShape(Circle())
            .frame(width: 44, height: 44)
        } else {
          Image("user-avatar")
            .clipShape(Circle())
            .frame(width: 44)
        }
        RatingView(rankAverage: review.ratingText)
      }

      VStack(spacing: 12) {
        Text(review.author)
          .font(MovieBrowserFontsStyle.body.bold())
          .lineLimit(1)
          .foregroundStyle(Color.secondaryOrange)
          .frame(maxWidth: .infinity, alignment: .leading)

        Text(review.content)
          .font(MovieBrowserFontsStyle.body)
          .lineLimit(.max)
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity, alignment: .leading)

        if let date = review.createdAtText {
          HStack(spacing: 5) {
            Image(systemName: "calendar")
              .foregroundStyle(.white)
            Text(date)
              .font(MovieBrowserFontsStyle.footnote.bold())
              .lineLimit(1)
              .foregroundStyle(.white)
              .frame(maxWidth: .infinity, alignment: .leading)
          }
        }
      }
    }
  }

  private func loadNextPageIfNeeded(_ review: UserReviewModel) {
    guard review.id == reviews.last?.id, !isLoading else { return }
    Task {
      await loadNextPage()
    }
  }
}

#Preview {
  ReviewsView(isLoading: true,
              reviews: ReviewModel.mock().reviews,
              loadNextPage: {})
}
