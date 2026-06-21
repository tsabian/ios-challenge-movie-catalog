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
      ScrollView(.vertical) {
        VStack(spacing: 24) {
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
      .navigationDestination(for: SearchFeatures.self) { router in
        switch router {
        case let .movieDetails(selectedMovie):
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
    VStack(spacing: 24) {
      ForEach(movies, id: \.id) { movie in
        HStack {
          RemotePosterView(viewModel: appContainer.viewModelFactory.makeRemotePoster(),
                           pathURLString: movie.posterPath)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .frame(maxWidth: 95)
          VStack(alignment: .leading, spacing: 8) {
            Text(movie.title)
              .lineLimit(1)
              .font(MovieBrowserFontsStyle.body.bold())
            Spacer()
            Label(movie.rankAverageText, systemImage: "star")
              .foregroundStyle(Color.secondaryOrange)
              .font(MovieBrowserFontsStyle.body)
            if let genre = movie.genre {
              Label(viewModel.getGenreName(id: genre), systemImage: "ticket")
                .font(MovieBrowserFontsStyle.body)
            }
            Label(movie.releaseYear, systemImage: "calendar")
              .font(MovieBrowserFontsStyle.body)
            if movie.runtime > 0 {
              Label("\(movie.runtime)", systemImage: "clock")
                .font(MovieBrowserFontsStyle.body)
            }
          }
          .padding(.leading, 8)
          Spacer()
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
          viewModel.requestDetails(selectedMovie: movie)
          bindingFeature()
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

  private func handleNavigate(_ feature: SearchFeatures) {
    switch feature {
    case let .movieDetails(movie):
      router.openMovieDetails(movie: movie)
    }
  }

  private func bindingFeature() {
    switch viewModel.navigate {
    case let .movieDetails(movie):
      router.openMovieDetails(movie: movie)
    case .none:
      break
    }
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
