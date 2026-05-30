//
//  HomeView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 24/05/26.
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModelProtocol>: View {
  @Environment(\.appContainer) private var appContainer
  @StateObject private var viewModel: ViewModel

  init(viewModel: @autoclosure @escaping () -> ViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel())
  }

  var body: some View {
    NavigationStack(path: $viewModel.path) {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .leading, spacing: 15) {
          Text(.whatDoYouWantToWatch)
            .foregroundStyle(.white)
            .font(MovieBrowserFontsStyle.title)

          SearchField(onSearch: handleSearch,
                      onTextChange: handleSearchTextChange,
                      onClear: handleSearchClear)

          content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding([.leading, .trailing], 22)
      }
      .background {
        Color.accentColor.ignoresSafeArea()
      }
      .navigationDestination(for: HomeRouter.self) { route in
        switch route {
        case let .movieDetails(details):
          MovieDetailView(
            viewModel: appContainer.viewModelFactory.makeMovieDetail(detail: details)
          )
        }
      }
    }
    .task {
      await viewModel.load()
    }
  }

  @ViewBuilder
  private var content: some View {
    switch viewModel.state {
    case .idle, .loading:
      HomeSkeletonView(currentCategory: $viewModel.currentCategory,
                       onCategorySelect: handleCategorySelect(_:))
        .frame(maxWidth: .infinity, alignment: .leading)
    case let .loaded(content):
      RankedListPostersView(movies: content.rankedMovies,
                            tapAction: handleMovieTap(_:))
      CategoryView(currentCategory: $viewModel.currentCategory,
                   onCategorySelect: handleCategorySelect)
      if !content.movies.isEmpty {
        LazyMovieGridView(movies: content.movies,
                          tapAction: handleMovieTap(_:))
      } else {
        CollectionEmptyStateView(title: String(localized: .noResultsTitle),
                                 message: String(localized: .noResultsMessage))
      }
    case .empty:
      CollectionEmptyStateView(title: String(localized: .noResultsTitle),
                               message: String(localized: .noResultsMessage))
    case .error:
      EmptyView()
    }
  }

  private func handleSearch(_ query: String) {
    viewModel.searchText = query
    print("Search: \(query)")
  }

  private func handleSearchTextChange(_ query: String) {
    viewModel.searchText = query
    print(query)
  }

  private func handleSearchClear() {
    viewModel.searchText = ""
    print("clear")
  }

  private func handleCategorySelect(_ category: MovieCategory) {
    Task {
      await viewModel.select(category: category)
    }
  }

  private func handleMovieTap(_ movie: MovieModel) {
    viewModel.requestDetail(movie: movie)
  }
}

#Preview {
  HomeView(
    viewModel: HomeViewPreviewMockFactory.make()
      .change(state: .loaded(content: .mock()))
  )
}
