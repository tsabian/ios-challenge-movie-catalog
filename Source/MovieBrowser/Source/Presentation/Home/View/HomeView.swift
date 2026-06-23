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
  @Binding private var router: HomeRouter
  @FocusState private var isSearchFieldFocused: Bool
  @State private var searchText: String = ""

  var openSearch: ((String) -> Void)?

  init(viewModel: @autoclosure @escaping () -> ViewModel,
       router: Binding<HomeRouter>,
       openSearch: ((String) -> Void)?) {
    _viewModel = StateObject(wrappedValue: viewModel())
    _router = router
    self.openSearch = openSearch
  }

  var body: some View {
    NavigationStack(path: $router.path) {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .leading, spacing: 15) {
          Text(.whatDoYouWantToWatch)
            .foregroundStyle(.white)
            .font(MovieBrowserFontsStyle.title)

          SearchField(searchText: $searchText,
                      onSearch: handleSearch,
                      onClear: handleSearchClear,
                      isSearchFocused: $isSearchFieldFocused)

          content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding([.leading, .trailing], 22)
      }
      .background {
        Color.accentColor.ignoresSafeArea()
      }
      .navigationDestination(for: HomeRouterFeatures.self) { route in
        switch route {
        case let .openDetails(selectedMovie):
          MovieDetailView(
            viewModel: appContainer.viewModelFactory.makeMovieDetail(movie: selectedMovie)
          )
        }
      }
    }
    .contentShape(Rectangle())
    .onTapGesture {
      isSearchFieldFocused = false
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
      loadedContent(content)
    case .empty:
      AlternativeFlowStateView(title: String(localized: .noResultsTitle),
                               message: String(localized: .noResultsMessage))
    case .error:
      errorState()
    }
  }

  private func loadedContent(_ content: HomeContentModel) -> some View {
    VStack {
      RankedListPostersView(movies: content.rankedMovies,
                            tapAction: handleNavigate)

      CategoryView(currentCategory: $viewModel.currentCategory,
                   onCategorySelect: handleCategorySelect)

      if let catalog = content.movieCatalog[viewModel.currentCategory] {
        LazyMovieGridView(movieCatalog: catalog,
                          isLoadingNextPage: viewModel.isLoadingNextPage,
                          loadNextPage: viewModel.loadNextPage,
                          tapAction: handleNavigate)
      } else {
        AlternativeFlowStateView(title: String(localized: .noResultsTitle),
                                 message: String(localized: .noResultsMessage))
      }
    }
  }

  private func errorState() -> some View {
    AlternativeFlowStateView(title: String(localized: .somethingWentWrong),
                             message: String(localized: .tryAgainFewMinutes),
                             imageName: .error)
  }

  private func handleSearch(query: String) {
    openSearch?(query)
  }

  private func handleCategorySelect(_ category: MovieCategory) {
    Task {
      await viewModel.select(category: category)
    }
  }

  private func handleNavigate(_ movie: MovieModel) {
    isSearchFieldFocused = false
    router.navigation(to: .openDetails(movie: movie))
  }

  private func handleSearchClear() {
    searchText = ""
  }
}

#Preview {
  HomeView(
    viewModel: HomeViewPreviewMockFactory.make()
      .change(state: .loaded(content: .mock())),
    router: .constant(.init()),
    openSearch: { _ in }
  )
}
