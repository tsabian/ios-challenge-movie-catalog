//
//  MovieGridSkeletonView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import SwiftUI

struct MovieGridSkeletonView: View {
  private let columns = [
    GridItem(.flexible(), spacing: 12),
    GridItem(.flexible(), spacing: 12),
    GridItem(.flexible(), spacing: 12)
  ]

  let count: Int

  var body: some View {
    LazyVGrid(columns: columns) {
      ForEach(0 ..< count, id: \.self) { _ in
        MoviePosterSkeletonCardView(width: 100, height: 145)
      }
    }
  }
}

#Preview {
  MovieGridSkeletonView(count: 5)
}
