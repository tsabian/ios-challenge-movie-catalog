//
//  MovieDetailView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 28/05/26.
//

import SwiftUI

struct MovieDetailView<ViewModel: MovieDetailViewModelProtocol>: View {
  @StateObject private var viewModel: ViewModel

  init(viewModel: @autoclosure @escaping () -> ViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel())
  }

  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      content
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button {} label: {
          Image(systemName: "bookmark.fill")
        }
      }
    }
    .ignoresSafeArea(edges: .top)
    .scrollContentBackground(.hidden)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background {
      AppBackgroundView(pathURLString: viewModel.backdropPath)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
    .task {
      await viewModel.load()
    }
  }

  @ViewBuilder
  var content: some View {
    switch viewModel.state {
    case .idle, .loading:
      EmptyView()
    case let .loaded(detail):
      MovieDetailContentView(movieDetail: detail,
                             infoTapAction: handleReviewsTap)
    case let .reviews(reviews):
      EmptyView()
    case .empty:
      EmptyView()
    case .error:
      EmptyView()
    }
  }

  private func handleReviewsTap(_: DetailInfo) {
    viewModel.requestNextPage()
  }
}

#Preview {
  MovieDetailView(
    viewModel: MovieDetailPreviewMockFactory.make(state: .loaded(detail: .mock()))
  )
}
