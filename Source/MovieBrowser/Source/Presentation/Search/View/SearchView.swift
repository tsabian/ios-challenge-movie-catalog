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
  @Binding private var query: String
  @FocusState private var isSearchFieldFocused: Bool

  init(viewModel: @autoclosure @escaping () -> ViewModel,
       query: Binding<String>) {
    _viewModel = StateObject(wrappedValue: viewModel())
    _query = query
  }

  var body: some View {
    NavigationStack(path: $viewModel.path) {
      ScrollView(.vertical) {
        VStack(spacing: 24) {
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
      .navigationDestination(for: SearchRouter.self) { router in
        switch router {
        case let .movieDetails(selectedMovie):
          MovieDetailView(
            viewModel: appContainer.viewModelFactory.makeMovieDetail(movie: selectedMovie)
          )
        }
      }
    }
    .navigationTitle(.search)
    .navigationBarTitleDisplayMode(.inline)
    .ignoresSafeArea()
    .background {
      Color.accentColor.ignoresSafeArea()
    }
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
      loadedViewState(movies: content.movies)
    case .idle, .empty:
      Spacer()
      CollectionEmptyStateView(title: String(localized: .noResultsTitle),
                               message: String(localized: .noResultsMessage))
      Spacer()
    case .error:
      errorViewState()
    }
  }

  private func loadingViewState() -> some View {
    LoadingView()
  }

  private func loadedViewState(movies: [SearchMovieResultModel]) -> some View {
    VStack(alignment: .trailing, spacing: 24) {
      ForEach(movies, id: \.id) { movie in
        HStack(spacing: 24) {
          RemotePosterView(viewModel: appContainer.viewModelFactory.makeRemotePoster(),
                           pathURLString: movie.posterPath)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .frame(maxWidth: 95)
          VStack(alignment: .leading, spacing: 4) {
            Text(movie.title)
              .lineLimit(1)
              .font(MovieBrowserFontsStyle.subTitle)
            Spacer()
            Label(movie.rankAverageText, systemImage: "star")
              .foregroundStyle(Color.secondaryOrange)
              .font(MovieBrowserFontsStyle.body)
            Label("Acao", systemImage: "ticket")
              .font(MovieBrowserFontsStyle.body)
            Label(movie.releaseYear, systemImage: "calendar")
              .font(MovieBrowserFontsStyle.body)
            Label("\(movie.runtime)", systemImage: "clock")
              .font(MovieBrowserFontsStyle.body)
          }
          Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
          viewModel.requestDetails(selectedMovie: movie)
        }
      }
    }
  }

  private func errorViewState() -> some View {
    // TODO: add error state
    VStack(spacing: 10) {
      Text("error")
    }
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
}

#Preview {
  SearchView(
    viewModel: SearchViewPreviewMockFactory
      .make()
      .setStateView(state: .loaded(content: .mock())),
    query: .constant("")
  )
}
