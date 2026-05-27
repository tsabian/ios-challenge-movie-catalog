//
//  CategoryView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

struct CategoryView: View {
  @State private var opacity: Double = 1
  @Binding var currentCategory: MovieCategory
  @Environment(\.onCategorySelectAction) private var onCategorySelectAction

  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(alignment: .top, spacing: 7) {
        ForEach(MovieCategory.allCases, id: \.self) { element in
          VStack(spacing: 4) {
            Text(element.title)
              .font(MovieBrowserFontsStyle.footnote)
            Rectangle()
              .foregroundStyle(Color.accentColor)
              .frame(height: currentCategory == element ? 5.0 : 0)
              .opacity(currentCategory == element ? 1.0 : 0)
              .animation(.easeInOut(duration: 0.4), value: currentCategory)
          } //: VStack
          .frame(width: 100)
          .contentShape(Rectangle())
          .onTapGesture {
            guard currentCategory != element else { return }
            currentCategory = element
            onCategorySelectAction?(element)
          }
        } //: ForEach
      } //: HStack
    } //: ScrollView
  }
}

extension CategoryView {
  func onCategorySelect(perform action: @escaping (MovieCategory) -> Void) -> some View {
    environment(\.onCategorySelectAction, action)
  }
}

#Preview {
  CategoryView(currentCategory: .constant(.nowPlaying))
}
