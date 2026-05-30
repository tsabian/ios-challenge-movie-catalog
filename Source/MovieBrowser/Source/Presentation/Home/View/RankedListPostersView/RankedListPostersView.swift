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

  let movies: [MovieModel]
  var tapAction: (MovieModel) -> Void

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
            .padding([.bottom, .trailing], 20)
            .offset(x: 11)
            .onTapGesture {
              tapAction(movie)
            }
        }
      }
    }
  }
}

#Preview {
  RankedListPostersView(movies: .mock(type: .nowPlaying), tapAction: { _ in })
}
