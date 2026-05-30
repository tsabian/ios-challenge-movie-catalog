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

  var body: some View {
    if isLoading {
      LoadingView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    } else {
      if reviews.isEmpty {
        CollectionEmptyStateView(title: String(localized: .thereIsNoReviewYet),
                                 message: String(localized: .noResultsMessage))
      } else {
        content
      }
    }
  }

  private var content: some View {
    VStack(spacing: 12) {
      ForEach(reviews, id: \.id) { review in
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
            RatingView(rankAverage: review.rating)
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

            HStack(spacing: 5) {
              Image(systemName: "calendar")
                .foregroundStyle(.white)
              if let data = review.createdAt {
                Text(data)
                  .font(MovieBrowserFontsStyle.footnote.bold())
                  .lineLimit(1)
                  .foregroundStyle(.white)
                  .frame(maxWidth: .infinity, alignment: .leading)
              }
            }
          }
        }
        Divider()
      }
    }
    .padding(.bottom, 84)
  }
}

#Preview {
  ReviewsView(isLoading: false,
              reviews: ReviewModel.mock().reviews)
}
