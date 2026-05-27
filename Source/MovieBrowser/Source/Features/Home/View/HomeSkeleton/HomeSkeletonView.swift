//
//  HomeSkeletonView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import SwiftUI

struct HomeSkeletonView: View {
  @Binding var currentCategory: MovieCategory
  let onCategorySelect: (MovieCategory) -> Void

  var body: some View {
    RankedListPostersSkeletonView(count: 5)

    CategoryView(
      currentCategory: $currentCategory,
      onCategorySelect: onCategorySelect
    )
    .disabled(true)

    MovieGridSkeletonView(count: 9)
  }
}

#Preview {
  HomeSkeletonView(currentCategory: .constant(.nowPlaying)) { _ in
  }
}
