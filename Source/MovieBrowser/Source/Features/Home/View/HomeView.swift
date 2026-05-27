//
//  HomeView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 24/05/26.
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModelProtocol>: View {
  @StateObject private var viewModel: ViewModel

  init(viewModel: @autoclosure @escaping () -> ViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel())
  }

  var body: some View {
    ScrollView(.vertical) {
      VStack(alignment: .leading, spacing: 16) {
        Text(.whatDoYouWantToWatch)
          .font(MovieBrowserFontsStyle.title)
        SearchField(onSearch: handleSearch,
                    onTextChange: handleSearchTextChange,
                    onClear: handleSearchClear)
        content
      }
      .padding(12)
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
    case let .loaded(content):
      RankedListPostersView(movies: content.rankedMovies,
                            onMovieSelect: handleMovieSelect)
      CategoryView(currentCategory: $viewModel.currentCategory,
                   onCategorySelect: handleCategorySelect)
      if !content.movies.isEmpty {
        LazyMovieGridView(movies: content.movies,
                          onMovieSelect: handleMovieSelect)
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

  private func handleMovieSelect(_ movie: HomeMovieModel) {
    print(movie.id)
  }

  private func handleCategorySelect(_ category: MovieCategory) {
    Task {
      await viewModel.select(category: category)
    }
  }
}

#Preview {
  HomeView(
    viewModel: HomeViewPreviewMockFactory
      .makeViewModelMock(
        state:
            .loaded(
              content: HomeContent(
                rankedMovies: MovieAdapter()
                  .adapt(dto: PreviewFactory.shared
                    .makeMovieCatalog(
                      for: .topRated
                    ).results, for: .topRated),
                movies: MovieAdapter()
                  .adapt(dto: PreviewFactory.shared
                    .makeMovieCatalog(
                      for: .topRated
                    ).results, for: .topRated)
              )
            )
      )
  )
}
