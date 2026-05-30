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

  let movies: [MovieModel]
  let tapAction: (MovieModel) -> Void

  var body: some View {
    LazyVGrid(columns: colunas) {
      ForEach(Array(movies.enumerated()), id: \.offset) { index, movie in
        MovieRankCardView(posterWidth: 100,
                          posterHeight: 145,
                          imageName: movie.posterPath,
                          rank: movie.rank,
                          isRankHidden: true)
          .contentShape(Rectangle())
          .frame(maxWidth: .infinity, alignment: alignmentForIndex(index))
          .onTapGesture {
            tapAction(movie)
          }
      }
    }
  }

  func alignmentForIndex(_ index: Int) -> Alignment {
    switch index % 3 {
    case 0: .leading
    case 1: .center
    default: .trailing
    }
  }
}

#Preview {
  LazyMovieGridView(movies: .mock(type: .nowPlaying),
                    tapAction: { _ in })
}
