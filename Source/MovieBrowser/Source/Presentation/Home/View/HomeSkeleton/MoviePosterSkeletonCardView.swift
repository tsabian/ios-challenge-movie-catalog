//
//  MoviePosterSkeletonCardView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import SwiftUI

struct MoviePosterSkeletonCardView: View {
  let width: CGFloat
  let height: CGFloat

  var body: some View {
    RoundedRectangle(cornerRadius: 10)
      .fill(Color.accentGray.opacity(0.3))
      .frame(width: width, height: height)
      .shimmer(isActive: true)
      .redacted(reason: .placeholder)
  }
}

#Preview {
  MoviePosterSkeletonCardView(width: 144, height: 210)
}
