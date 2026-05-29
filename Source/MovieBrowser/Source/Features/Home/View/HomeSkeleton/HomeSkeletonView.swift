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
    VStack {
      RankedListPostersSkeletonView(count: 5)

      CategoryView(
        currentCategory: $currentCategory,
        onCategorySelect: onCategorySelect
      )
      .disabled(true)

      MovieGridSkeletonView(count: 9)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding([.leading, .trailing], 22)
  }
}

#Preview {
  HomeSkeletonView(currentCategory: .constant(.nowPlaying)) { _ in
  }
}
