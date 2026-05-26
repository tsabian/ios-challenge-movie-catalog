//
//  MovieRankCardView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

struct MovieRankCardView: View {
  let posterWidth: CGFloat
  let posterHeight: CGFloat
  let imageName: String
  let rank: Int
  let outLinetextOffSet = CGPoint(x: -5, y: 30)
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
          .font(MontserratFont.bold.size(100))
          .outline(color: Color.accentBlue, width: 1,
                   fillColor: Color.accentColor)
          .offset(x: outLinetextOffSet.x, y: outLinetextOffSet.y)
          .shadow(color: Color.black.opacity(0.10), radius: 2, x: 8, y: 2)
      }
    }
    .frame(width: posterWidth, height: posterHeight)
  }
}

#Preview {
  MovieRankCardView(posterWidth: 140, posterHeight: 235,
                    imageName: "popcorn", rank: 1,
                    isRankHidden: false)
}
