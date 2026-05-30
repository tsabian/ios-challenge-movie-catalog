//
//  CategoryView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

struct CategoryView: View {
  private let onCategorySelect: (MovieCategory) -> Void

  @Binding var currentCategory: MovieCategory

  init(currentCategory: Binding<MovieCategory>,
       onCategorySelect: @escaping (MovieCategory) -> Void = { _ in }) {
    _currentCategory = currentCategory
    self.onCategorySelect = onCategorySelect
  }

  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(alignment: .top, spacing: 7) {
        ForEach(MovieCategory.allCases, id: \.self) { element in
          VStack(spacing: 4) {
            Text(element.title)
              .font(MovieBrowserFontsStyle.footnote)
            Rectangle()
              .foregroundStyle(Color.accentGray)
              .frame(height: currentCategory == element ? 5.0 : 0)
              .opacity(currentCategory == element ? 1.0 : 0)
              .animation(.easeInOut(duration: 0.4), value: currentCategory)
          } //: VStack
          .frame(width: 100)
          .contentShape(Rectangle())
          .onTapGesture {
            guard currentCategory != element else { return }
            currentCategory = element
            onCategorySelect(element)
          }
        } //: ForEach
      } //: HStack
    } //: ScrollView
  }
}

#Preview {
  CategoryView(currentCategory: .constant(.nowPlaying))
}
