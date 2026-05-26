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
        RankedListPostersView(movies: viewModel.rankedMovies)
          .onMovieSelectAction { movie in
            print(movie.id)
          }
        CategoryView(currentCategory: $viewModel.currentCategory)
          .onCategorySelect { category in
            print(category.rawValue)
          }
        if viewModel.movies.isEmpty {
          CollectionEmptyStateView(title: String(localized: .noResultsTitle),
                                   message: String(localized: .noResultsMessage))
        } else {
          LazyMovieGridView(movies: viewModel.movies)
            .onMovieSelect { movie in
              print(movie.id)
            }
        }
      } //: VStack
      .padding(12)
    } //: Scroll
    .onAppear {
      viewModel.fetch()
    }
  }
}

#Preview {
  HomeView(viewModel: HomeViewModel())
}
