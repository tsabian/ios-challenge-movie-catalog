//
//  MovieDetailView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 28/05/26.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
  static var defaultValue: CGFloat = 0
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = nextValue()
  }
}

struct MovieDetailView<ViewModel: MovieDetailViewModelProtocol>: View {
  @Environment(\.appContainer) private var appContainer
  @Environment(HomeRouter.self) private var homeRouter

  @StateObject private var viewModel: ViewModel

  init(viewModel: @autoclosure @escaping () -> ViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel())
  }

  var body: some View {
    VStack {
      ScrollView(.vertical, showsIndicators: false) {
        content
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    .toolbar {
      ToolbarItemGroup(placement: .topBarTrailing) {
        Button {
          viewModel.addOrRemoveWatchList()
        } label: {
          Image(systemName: viewModel.isBookmark ? "bookmark.fill" : "bookmark")
        }

        if let url = viewModel.makeMovieURL(),
           let image = viewModel.imagePreview {
          ShareLink(item: url,
                    subject: Text(viewModel.movieTitle),
                    preview: SharePreview(viewModel.movieTitle,
                                          image: Image(uiImage: image))) {
            Image(systemName: "square.and.arrow.up")
          }
        }
      }
    }
    .navigationTitle(viewModel.movieTitle)
    .navigationBarTitleDisplayMode(.inline)
    .ignoresSafeArea(edges: [.horizontal])
    .background {
      AppBackgroundView(pathURLString: viewModel.backdropPath)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
    .task {
      await viewModel.loadIfNeeded()
    }
  }

  @ViewBuilder
  private var content: some View {
    switch viewModel.state {
    case .idle, .loading:
      LoadingView()
    case let .loaded(contentState):
      MovieDetailContentView(
        contentState: contentState,
        infoTapAction: handleRequest,
        loadReviewNextPage: handleReviewNextPage
      )
      .environment(homeRouter)
    case .error:
      AlternativeFlowStateView(title: String(localized: .somethingWentWrong),
                               message: String(localized: .tryAgainFewMinutes),
                               imageName: .error)
    }
  }

  private func handleRequest(info: DetailInfo) {
    switch info {
    case .reviews:
      requestReviews()
    case .cast:
      requestCast()
    case .about:
      break
    case .providers:
      requestWatchProviders()
    case .recommendations:
      requestRecommendations()
    }
  }

  private func handleReviewNextPage() {
    requestReviews()
  }

  private func requestReviews() {
    Task {
      await viewModel.loadReviewsIfNeeded()
    }
  }

  private func requestCast() {
    Task {
      await viewModel.loadCastIfNeeded()
    }
  }

  private func requestWatchProviders() {
    Task {
      await viewModel.loadWatchProvidersIfNeeded()
    }
  }

  private func requestRecommendations() {
    Task {
      await viewModel.loadRecommendationsIfNeeded()
    }
  }
}

#Preview {
  MovieDetailView(
    viewModel: MovieDetailPreviewMockFactory
      .make(state: .loaded(.mock(isLoadingReviews: true, isLoadingCast: true)))
  )
}
