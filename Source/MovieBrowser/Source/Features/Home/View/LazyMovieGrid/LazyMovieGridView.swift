//
//  LazyMovieGridView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 26/05/26.
//

import SwiftUI

struct LazyMovieGridView: View {
  private let colunas = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible())
  ]

  let movies: [HomeMovieModel]

  var body: some View {
    LazyVGrid(columns: colunas) {
      ForEach(Array(movies.enumerated()), id: \.offset) { index, movie in
        NavigationLink(value: movie) {
          MovieRankCardView(posterWidth: 100,
                            posterHeight: 145,
                            imageName: movie.posterPath,
                            rank: movie.rank,
                            isRankHidden: true)
            .contentShape(Rectangle())
            .frame(maxWidth: .infinity, alignment: alignmentForIndex(index))
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
  let catalog = PreviewFactory.shared.makeMovieCatalog(for: .nowPlaying)
  let movies = MovieAdapter().adapt(dto: catalog.results)
  LazyMovieGridView(movies: movies)
}
