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

  @Environment(\.onMovieSelectAction) var onMovieSelectAction
  let movies: [HomeMovieModel]

  var body: some View {
    LazyVGrid(columns: colunas, spacing: 16) {
      ForEach(movies) { movie in
        MovieRankCardView(posterWidth: 100,
                          posterHeight: 145,
                          imageName: movie.posterPath,
                          rank: movie.rank,
                          isRankHidden: true)
          .contentShape(Rectangle())
          .onTapGesture {
            onMovieSelectAction?(movie)
          }
      } //: ForEach
    } //: LazyVGrid
  }
}

extension LazyMovieGridView {
  func onMovieSelect(perform action: @escaping (HomeMovieModel) -> Void) -> some View {
    environment(\.onMovieSelectAction, action)
  }
}

#Preview {
  let catalog = PreviewFactory.shared.makeMovieCatalog(for: .nowPlaying)
  let movies = MovieAdapter().adapt(dto: catalog.results, for: .nowPlaying)
  LazyMovieGridView(movies: movies)
}
