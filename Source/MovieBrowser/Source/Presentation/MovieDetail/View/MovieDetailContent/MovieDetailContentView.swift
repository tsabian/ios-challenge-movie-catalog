//
//  MovieDetailContentView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import SwiftUI

struct MovieDetailContentView: View {
  @Environment(\.appContainer) private var appContainer
  @Environment(\.dynamicTypeSize) private var dynamicTypeSize
  @ScaledMetric(relativeTo: .body) private var posterWidth: CGFloat = 95
  @ScaledMetric(relativeTo: .body) private var posterHeight: CGFloat = 120
  @ScaledMetric(relativeTo: .body) private var backdropHeight: CGFloat = 210
  @State private var currentInfo: DetailInfo = .about

  private var isAccessibilitySize: Bool {
    dynamicTypeSize.isAccessibilitySize
  }

  var contentState: MovieDetailContentState
  var infoTapAction: (DetailInfo) -> Void

  init(contentState: MovieDetailContentState,
       infoTapAction: @escaping (DetailInfo) -> Void) {
    self.contentState = contentState
    self.infoTapAction = infoTapAction
  }

  var body: some View {
    ZStack(alignment: .top) {
      RemotePosterView(viewModel: appContainer.viewModelFactory.makeRemotePoster(),
                       pathURLString: contentState.detail.backdropPath,
                       size: .medium)
        .scaledToFill()
        .frame(height: min(backdropHeight, 260))
        .frame(maxWidth: .infinity)
        .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 0,
                                                             bottomLeading: 16,
                                                             bottomTrailing: 16,
                                                             topTrailing: 0)))

      VStack {
        headerContent
        metadata
        info
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  private var headerContent: some View {
    VStack(spacing: 16) {
      ZStack {
        HStack(alignment: .top, spacing: 12) {
          RemotePosterView(viewModel: appContainer.viewModelFactory.makeRemotePoster(),
                           pathURLString: contentState.detail.posterPath,
                           size: .small)
            .frame(width: min(posterWidth, 130), height: min(posterHeight, 165))
            .cornerRadius(16)

          VStack(alignment: .leading) {
            Spacer()
            Text(contentState.detail.title)
              .font(MovieBrowserFontsStyle.subTitle.bold())
              .lineLimit(isAccessibilitySize ? nil : 3)
              .frame(height: 80)
              .frame(maxWidth: .infinity, alignment: .leading)
              .fixedSize(horizontal: false, vertical: true)
          }
          .frame(height: 120)
        }
        .padding(.top, 160)
        .padding(.horizontal, 16)

        RatingView(rankAverage: String(format: "%.2f", contentState.detail.rankAverage))
          .frame(maxWidth: .infinity, alignment: .trailing)
          .padding(.trailing, 16)
          .offset(y: 33)
      }
    }
  }

  private var metadata: some View {
    ViewThatFits {
      HStack {
        Label("\(contentState.detail.releaseYear)", systemImage: "calendar")
        Text("|")
        Label(String(localized: .runtimeMinutes(contentState.detail.runtime)), systemImage: "clock")
        Text("|")
        Label(contentState.detail.genre, systemImage: "ticket")
      }
      VStack {
        Label("\(contentState.detail.releaseYear)", systemImage: "calendar")
        Label(.runtimeMinutes(contentState.detail.runtime), systemImage: "clock")
        Label(contentState.detail.genre, systemImage: "ticket")
      }
    }
    .foregroundStyle(Color.accentLightGray)
    .padding(.top, 16)
  }

  private var info: some View {
    VStack {
      HStack(alignment: .top, spacing: 12) {
        ForEach(DetailInfo.allCases, id: \.self) { element in
          VStack {
            Text(element.title)
              .font(MovieBrowserFontsStyle.body.bold())
              .lineLimit(1)
            Rectangle()
              .fill(Color.accentLightGray)
              .frame(maxWidth: .infinity)
              .frame(height: currentInfo == element ? 5.0 : 0)
              .opacity(currentInfo == element ? 1.0 : 0)
              .animation(.easeInOut(duration: 0.4), value: currentInfo)
          }
          .contentShape(Rectangle())
          .onTapGesture {
            guard currentInfo != element else { return }
            currentInfo = element
            infoTapAction(element)
          }
        }
      }
      .padding(.bottom, 16)

      switch currentInfo {
      case .about: aboutMovie
      case .reviews: reviews
      case .cast: cast
      }
    }
    .frame(maxWidth: .infinity)
    .padding(.top, 16)
    .padding(.horizontal, 16)
  }

  private var aboutMovie: some View {
    Text(contentState.detail.overview)
  }

  private var reviews: some View {
    ReviewsView(isLoading: contentState.isLoadingReviews,
                reviews: contentState.reviews)
  }

  private var cast: some View {
    CastView(isLoading: contentState.isLoadingCast,
             cast: contentState.cast)
  }
}

#Preview {
  MovieDetailContentView(contentState: .mock(),
                         infoTapAction: { info in
                           debugPrint("review tap \(info)")
                         })
}
