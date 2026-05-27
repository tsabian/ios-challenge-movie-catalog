//
//  HomeView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 24/05/26.
//

import Foundation
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
        SearchField()
          .onMovieSearch { query in
            print("Search: \(query)")
          }
          .onTextChange { query in
            print(query)
          }
          .onTextClear {
            print("clear")
          }
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
      RankedListPostersView(isLoading: .constant(true),
                            movies: viewModel.makeSkelleton(count: 5))
      CategoryView(currentCategory: $viewModel.currentCategory)
      LazyMovieGridView(isLoading: .constant(true),
                        movies: viewModel.makeSkelleton(count: 9))
    case let .loaded(content):
      RankedListPostersView(isLoading: .constant(false),
                            movies: content.rankedMovies)
        .onMovieSelectAction { movie in
          print(movie.id)
        }
      CategoryView(currentCategory: $viewModel.currentCategory)
        .onCategorySelect { category in
          Task {
            await viewModel.select(category: category)
          }
        }
      if !content.movies.isEmpty {
        LazyMovieGridView(isLoading: .constant(false),
                          movies: content.movies)
          .onMovieSelect { movie in
            print(movie.id)
          }
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
