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
  private let onMovieSelect: (HomeMovieModel) -> Void

  @Binding var isLoading: Bool
  let movies: [HomeMovieModel]

  init(isLoading: Binding<Bool>,
       movies: [HomeMovieModel],
       onMovieSelect: @escaping (HomeMovieModel) -> Void = { _ in }) {
    _isLoading = isLoading
    self.movies = movies
    self.onMovieSelect = onMovieSelect
  }

  var body: some View {
    LazyVGrid(columns: colunas) {
      ForEach(movies) { movie in
        MovieRankCardView(isLoading: $isLoading,
                          posterWidth: 100,
                          posterHeight: 145,
                          imageName: movie.posterPath,
                          rank: movie.rank,
                          isRankHidden: true)
          .contentShape(Rectangle())
          .onTapGesture {
            onMovieSelect(movie)
          }
      }
    }
  }
}

#Preview {
  let catalog = PreviewFactory.shared.makeMovieCatalog(for: .nowPlaying)
  let movies = MovieAdapter().adapt(dto: catalog.results, for: .nowPlaying)
  LazyMovieGridView(isLoading: .constant(false), movies: movies)
}
