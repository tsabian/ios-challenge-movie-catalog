//
//  MovieRankCardView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

struct MovieRankCardView: View {
  @Binding var isLoading: Bool

  let posterWidth: CGFloat
  let posterHeight: CGFloat
  let imageName: String
  let rank: Int
  let outLinetextOffSet = CGPoint(x: -10, y: 40)
  let isRankHidden: Bool

  var body: some View {
    ZStack(alignment: .bottomLeading) {
      RemotePosterView(imageURL: imageName, width: posterWidth, height: posterHeight)
        .scaledToFill()
        .frame(width: posterWidth, height: posterHeight)
        .shadow(color: Color.accentColor.opacity(0.8), radius: 8, x: 0, y: 8)
        .cornerRadius(12)
      if !isRankHidden {
        Text("\(rank)")
          .font(MontserratFont.bold.size(90))
          .outline(color: Color.accentBlue, width: 1,
                   fillColor: Color.accentColor)
          .offset(x: outLinetextOffSet.x, y: outLinetextOffSet.y)
          .shadow(color: Color.black.opacity(0.10), radius: 2, x: 8, y: 2)
          .opacity(isLoading ? 0 : 1)
      }
    }
    .padding([.leading, .bottom])
  }
}

#Preview {
  let catalog = PreviewFactory.shared.makeMovieCatalog(for: .topRated)
  let movie = MovieAdapter().adapt(dto: catalog.results, for: .topRated)
  let imageName = movie.first?.posterPath ?? "popcorn"
  MovieRankCardView(isLoading: .constant(false),
                    posterWidth: 144, posterHeight: 210,
                    imageName: imageName, rank: 24,
                    isRankHidden: false)
}
