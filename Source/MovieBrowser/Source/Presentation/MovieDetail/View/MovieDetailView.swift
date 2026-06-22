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
          debugPrint("Save to watch list")
        } label: {
          Image(systemName: "bookmark.fill")
        }

        if let url = viewModel.makeMovieURL(),
           let imagePreview = viewModel.imagePreview {
          ShareLink(item: url,
                    preview: SharePreview(viewModel.movieTitle,
                                          image: imagePreview)) {
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
        infoTapAction: handleReviewsTap,
        makeRemotePosterViewModel: appContainer.viewModelFactory.makeRemotePoster()
      )
    case .error:
      EmptyView()
    }
  }

  private func handleReviewsTap(info: DetailInfo) {
    switch info {
    case .reviews:
      viewModel.requestNextPageForReviews()
    case .cast:
      viewModel.requestCast()
    case .about:
      break
    }
  }
}

#Preview {
  MovieDetailView(
    viewModel: MovieDetailPreviewMockFactory
      .make(state: .loaded(.mock(isLoadingReviews: true, isLoadingCast: true)))
  )
}
