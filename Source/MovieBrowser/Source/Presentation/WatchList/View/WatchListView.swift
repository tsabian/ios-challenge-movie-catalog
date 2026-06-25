//
//  WatchListView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 24/05/26.
//

import SwiftUI

struct WatchListView<ViewModel: WatchListViewModelProtocol>: View {
  @Environment(\.appContainer) private var appContainer
  @StateObject var viewModel: ViewModel
  @Binding private var router: HomeRouter

  private let columns = [
    GridItem(spacing: 10),
    GridItem(spacing: 10)
  ]

  init(viewModel: @autoclosure @escaping () -> ViewModel,
       router: Binding<HomeRouter>) {
    _viewModel = StateObject(wrappedValue: viewModel())
    _router = router
  }

  var body: some View {
    NavigationStack(path: $router.path) {
      VStack {
        Text(.watchList)
          .foregroundStyle(.white)
          .font(MovieBrowserFontsStyle.title)

        content()
        Spacer()
      }
      .navigationDestination(for: HomeRouterFeatures.self) { route in
        switch route {
        case let .openDetails(movie):
          MovieDetailView(
            viewModel: appContainer.viewModelFactory
              .makeMovieDetail(movie: movie))
            .environment(router)
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .padding()
      .ignoresSafeArea(edges: [.horizontal])
      .background {
        Color.accentColor.ignoresSafeArea()
      }
      .task {
        viewModel.loadIfNeeded()
      }
    }
  }

  @ViewBuilder
  private func content() -> some View {
    switch viewModel.state {
    case .idle, .loading:
      LoadingView()
    case let .loaded(content):
      listState(content)
    case .empty:
      emptyState()
    case .error:
      errorState()
    }
  }

  private func listState(_ content: [MovieDetailsModel]) -> some View {
    ScrollView(.vertical, showsIndicators: false) {
      LazyVGrid(columns: columns) {
        ForEach(content, id: \.id) { movie in
          VStack(spacing: 4) {
            ZStack {
              RemotePosterView(viewModel: appContainer.viewModelFactory.makeRemotePoster(),
                               pathURLString: movie.backdropPath)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            Text(movie.title)
              .font(MovieBrowserFontsStyle.caption)
              .lineLimit(1)
          }
          .clipShape(Rectangle())
          .frame(width: 160, height: 120)
          .onTapGesture {
            router.navigation(to: .openDetails(movie: viewModel.makeMovie(from: movie)))
          }
        }
      }
    }
  }

  private func emptyState() -> some View {
    AlternativeFlowStateView(title: String(localized: .thereIsNoMovieYet),
                             message: String(localized: .noResultsMessage),
                             imageName: .folder)
  }

  private func errorState() -> some View {
    AlternativeFlowStateView(title: String(localized: .somethingWentWrong),
                             message: String(localized: .tryAgainFewMinutes),
                             imageName: .error)
  }
}

#Preview {
  WatchListView(viewModel: WatchlistViewModelMockFactory
    .make()
    .update(state: .loaded(content: [
      .mock()
    ])), router: .constant(.init()))
}
