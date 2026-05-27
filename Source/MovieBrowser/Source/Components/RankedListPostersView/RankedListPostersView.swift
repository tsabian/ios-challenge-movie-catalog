//
//  RankedListPostersView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

struct RankedListPostersView: View {
  private let posterWidth: CGFloat = 144
  private let posterHeight: CGFloat = 210
  private let onMovieSelect: (HomeMovieModel) -> Void

  let movies: [HomeMovieModel]

  init(movies: [HomeMovieModel],
       onMovieSelect: @escaping (HomeMovieModel) -> Void = { _ in }) {
    self.movies = movies
    self.onMovieSelect = onMovieSelect
  }

  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(movies, id: \.id) { movie in
          MovieRankCardView(posterWidth: posterWidth,
                            posterHeight: posterHeight,
                            imageName: movie.posterPath,
                            rank: movie.rank,
                            isRankHidden: false)
            .contentShape(Rectangle())
            .padding(.bottom, 10)
            .onTapGesture {
              onMovieSelect(movie)
            }
        } //: ForEach
      } //: HStack
    } //: ScrollView
  }
}

#Preview {
  let image1 = "https://image.tmdb.org/t/p/w185/uIb9Tvae5haF0XcQBaPyufmxbb0.jpg"
  let image2 = "https://image.tmdb.org/t/p/w185/6X4qFYBsG3bpWDG2XIKqr04kFJa.jpg"
  let image3 = "https://image.tmdb.org/t/p/w185/io7wVbm9VKaanIcuAymCDy9dmjU.jpg"
  let movies: [HomeMovieModel] = [
    .init(id: 1, title: "Movie 1", posterPath: image1, rank: 1,
          category: .nowPlaying),
    .init(id: 2, title: "Movie 2", posterPath: image2, rank: 2,
          category: .nowPlaying),
    .init(id: 3, title: "Movie 3", posterPath: image3, rank: 3,
          category: .nowPlaying)
  ]
  RankedListPostersView(movies: movies)
}
