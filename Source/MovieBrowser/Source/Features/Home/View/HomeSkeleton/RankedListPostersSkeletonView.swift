//
//  RankedListPostersSkeletonView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import SwiftUI

struct RankedListPostersSkeletonView: View {
  let count: Int

  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(0 ..< count, id: \.self) { _ in
          MoviePosterSkeletonCardView(width: 144, height: 210)
            .padding([.bottom, .trailing], 20)
            .offset(x: 10)
        }
      }
    }
  }
}

#Preview {
  RankedListPostersSkeletonView(count: 5)
}
