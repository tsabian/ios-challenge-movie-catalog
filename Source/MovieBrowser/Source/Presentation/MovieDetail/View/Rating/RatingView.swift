//
//  RatingView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import SwiftUI

struct RatingView: View {
  var rankAverage: String

  var body: some View {
    Label(rankAverage, systemImage: "star")
      .font(MovieBrowserFontsStyle.footnote.bold())
      .foregroundStyle(Color.secondaryOrange)
      .padding(.horizontal, 10)
      .padding(.vertical, 6)
      .background(Color.accentColor)
      .clipShape(RoundedRectangle(cornerRadius: 8))
      .fixedSize()
  }
}

#Preview {
  RatingView(rankAverage: "8.7")
}
