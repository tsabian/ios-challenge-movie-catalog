//
//  SearchView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 24/05/26.
//

import SwiftUI

struct SearchView<ViewModel: SearchViewModelProtocol>: View {
  @Environment(\.appContainer) private var appContainer
  @StateObject private var viewModel: ViewModel
  @Binding private var router: SearchRouter
  @Binding private var query: String
  @FocusState private var isSearchFieldFocused: Bool

  init(viewModel: @autoclosure @escaping () -> ViewModel,
       router: Binding<SearchRouter>,
       query: Binding<String>) {
    _viewModel = StateObject(wrappedValue: viewModel())
    _router = router
    _query = query
  }

  var body: some View {
    NavigationStack(path: $router.path) {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 15) {
          Text(.search)
            .font(MovieBrowserFontsStyle.title.self)

          SearchField(searchText: $query,
                      onSearch: handleSearch,
                      onTextChange: handleSearchTextChange,
                      onClear: handleSearchClear,
                      isSearchFocused: $isSearchFieldFocused)
          content()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding([.leading, .trailing], 22)
      }
      .navigationDestination(for: SearchRouterFeatures.self) { router in
        switch router {
        case let .openDetails(selectedMovie):
          MovieDetailView(
            viewModel: appContainer.viewModelFactory.makeMovieDetail(movie: selectedMovie)
          )
        }
      }
      .background {
        Color.accentColor.ignoresSafeArea()
      }
    }
    .navigationTitle(.search)
    .navigationBarTitleDisplayMode(.inline)
    .ignoresSafeArea()
    .onTapGesture {
      isSearchFieldFocused = false
    }
    .task {
      guard !query.isEmpty else { return }
      await viewModel.search(movie: query)
    }
  }

  @ViewBuilder
  private func content() -> some View {
    switch viewModel.state {
    case .loading:
      loadingViewState()
    case let .loaded(content):
      loadedViewState(movieCatalog: content)
    case .idle, .empty:
      Spacer()
      AlternativeFlowStateView(title: String(localized: .noResultsTitle),
                               message: String(localized: .noResultsMessage))
      Spacer()
    case .error:
      errorViewState()
    }
  }

  private func loadingViewState() -> some View {
    LoadingView()
  }

  private func loadedViewState(movieCatalog: SearchMovieCatalogModel) -> some View {
    MovieListView(
      movieCatalog: movieCatalog,
      isLoadingNextPage: viewModel.isLoadingNextPage,
      getGenreName: viewModel.getGenreName,
      makeMovieModel: viewModel.makeMovieModel,
      loadNextPage: viewModel.loadNextPage,
      handleNavigate: handleNavigate
    )
  }

  private func errorViewState() -> some View {
    AlternativeFlowStateView(title: String(localized: .somethingWentWrong),
                             message: String(localized: .tryAgainFewMinutes),
                             imageName: .error)
  }

  private func handleSearch(text: String) {
    Task {
      await viewModel.search(movie: text)
    }
  }

  private func handleSearchTextChange(text _: String) {}

  private func handleSearchClear() {
    viewModel.reset()
  }

  private func handleNavigate(_ movie: MovieModel) {
    router.navigation(to: .openDetails(movie: movie))
  }
}

#Preview {
  SearchView(
    viewModel: SearchViewPreviewMockFactory
      .make()
      .setStateView(state: .loaded(content: .mock())),
    router: .constant(.init()),
    query: .constant("")
  )
}
