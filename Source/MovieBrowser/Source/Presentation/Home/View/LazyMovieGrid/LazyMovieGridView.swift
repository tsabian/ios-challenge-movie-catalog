//
//  LazyMovieGridView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 26/05/26.
//

import SwiftUI

struct LazyMovieGridView: View {
  private let colunas = [
    GridItem(.flexible(), spacing: 12),
    GridItem(.flexible(), spacing: 12),
    GridItem(.flexible(), spacing: 12)
  ]

  private let movieCatalog: MovieCatalogModel
  private let isLoadingNextPage: Bool
  private let loadNextPage: () async -> Void
  private let tapAction: (MovieModel) -> Void

  init(
    movieCatalog: MovieCatalogModel,
    isLoadingNextPage: Bool,
    loadNextPage: @escaping () async -> Void,
    tapAction: @escaping (MovieModel) -> Void
  ) {
    self.movieCatalog = movieCatalog
    self.isLoadingNextPage = isLoadingNextPage
    self.loadNextPage = loadNextPage
    self.tapAction = tapAction
  }

  var body: some View {
    VStack(alignment: .center) {
      LazyVGrid(columns: colunas) {
        ForEach(Array(movieCatalog.movies.enumerated()), id: \.offset) { index, movie in
          MovieRankCardView(posterWidth: 100,
                            posterHeight: 145,
                            imageName: movie.posterPath,
                            rank: movie.rank,
                            isRankHidden: true)
            .contentShape(Rectangle())
            .frame(maxWidth: .infinity, alignment: alignmentForIndex(index))
            .onAppear {
              loadNextPageIfNeeded(currentMovie: movie)
            }
            .onTapGesture {
              tapAction(movie)
            }
        }
      }
      if isLoadingNextPage {
        LoadingView()
      }
    }
  }

  private func alignmentForIndex(_ index: Int) -> Alignment {
    switch index % 3 {
    case 0: .leading
    case 1: .center
    default: .trailing
    }
  }

  private func loadNextPageIfNeeded(currentMovie: MovieModel) {
    guard currentMovie.id == movieCatalog.movies.last?.id,
          movieCatalog.page < movieCatalog.totalPages,
          !isLoadingNextPage else {
      return
    }
    Task {
      await loadNextPage()
    }
  }
}

#Preview {
  LazyMovieGridView(
    movieCatalog: .mock(type: .nowPlaying),
    isLoadingNextPage: true) {
      await Task.yield()
    } tapAction: { _ in
    }
}
