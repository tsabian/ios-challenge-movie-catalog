//
//  MovieDetailContentView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import Core
import SwiftUI

struct MovieDetailContentView<RemotePosterVM: RemotePosterViewModelProtocol>: View {
  @Environment(\.dynamicTypeSize) private var dynamicTypeSize
  @Environment(HomeRouter.self) private var router
  @ScaledMetric(relativeTo: .body) private var posterWidth: CGFloat = 95
  @ScaledMetric(relativeTo: .body) private var posterHeight: CGFloat = 120
  @ScaledMetric(relativeTo: .body) private var backdropHeight: CGFloat = 210
  @State private var currentInfo: DetailInfo = .about

  private let viewModel: () -> RemotePosterVM

  private var isAccessibilitySize: Bool {
    dynamicTypeSize.isAccessibilitySize
  }

  var contentState: MovieDetailContentState
  var infoTapAction: (DetailInfo) -> Void
  var loadReviewNextPage: () async -> Void

  init(contentState: MovieDetailContentState,
       infoTapAction: @escaping (DetailInfo) -> Void,
       loadReviewNextPage: @escaping () async -> Void,
       viewModel: @autoclosure @escaping () -> RemotePosterVM) {
    self.contentState = contentState
    self.infoTapAction = infoTapAction
    self.loadReviewNextPage = loadReviewNextPage
    self.viewModel = viewModel
  }

  var body: some View {
    ZStack(alignment: .top) {
      RemotePosterView(viewModel: viewModel(),
                       pathURLString: contentState.detail.backdropPath)
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
    VStack(alignment: .leading) {
      ZStack {
        HStack(alignment: .top, spacing: 4) {
          RemotePosterView(viewModel: viewModel(),
                           pathURLString: contentState.detail.posterPath,
                           size: .small)
            .frame(width: min(posterWidth, 130),
                   height: min(posterHeight, 165))
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
        .frame(maxWidth: .infinity)
        .padding(.top, 160)

        RatingView(rankAverage: contentState.detail.rankAverageText)
          .frame(maxWidth: .infinity, alignment: .trailing)
          .offset(y: 33)
      }

      if !contentState.detail.tagLine.isEmpty {
        Text(contentState.detail.tagLine)
          .font(MovieBrowserFontsStyle.caption)
          .lineLimit(isAccessibilitySize ? nil : 3)
      }
    }
    .padding(.horizontal, 16)
  }

  private var metadata: some View {
    ViewThatFits {
      HStack {
        Label(contentState.detail.releaseYear, systemImage: "calendar")
        Text("|")
        Label(contentState.detail.runtimeText, systemImage: "clock")
        if !contentState.detail.genre.isEmpty {
          Text("|")
          Label(contentState.detail.genre, systemImage: "ticket")
        }
      }
      VStack {
        Label(contentState.detail.releaseYear, systemImage: "calendar")
        Label(contentState.detail.runtimeText, systemImage: "clock")
        Label(contentState.detail.genre, systemImage: "ticket")
      }
    }
    .foregroundStyle(Color.accentLightGray)
    .padding([.vertical], 16)
  }

  private var info: some View {
    VStack {
      options
      switch currentInfo {
      case .about: aboutMovie
      case .reviews: reviews
      case .cast: cast
      case .providers: providers
      case .recomendations: recomendations
      }
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal, 16)
  }

  private var options: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(alignment: .top, spacing: 18) {
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
    }
  }

  private var aboutMovie: some View {
    Text(contentState.detail.overview)
      .padding()
  }

  private var reviews: some View {
    ReviewsView(isLoading: contentState.isLoadingReviewsNextPage,
                reviews: contentState.reviews,
                loadNextPage: loadReviewNextPage)
  }

  private var cast: some View {
    CastView(isLoading: contentState.isLoadingCast,
             cast: contentState.cast)
  }

  private var providers: some View {
    WatchProvidersView(isLoading: contentState.isLoadingWatchProviders,
                       providers: contentState.watchProviders)
  }

  private var recomendations: some View {
    RecomendationsView(movieCatalog: contentState.recomendations,
                       isLoading: contentState.isLoadingRecomendations,
                       handleDetail: handleDetail)
  }

  private func handleDetail(_ movie: MovieModel) {
    router.navigation(to: .openDetails(movie: movie))
  }
}

#Preview {
  MovieDetailContentView(contentState: .mock(),
                         infoTapAction: { info in
                           debugPrint("review tap \(info)")
                         },
                         loadReviewNextPage: {
                           debugPrint("review next page")
                         },
                         viewModel: RemotePosterViewModelMock())
}
