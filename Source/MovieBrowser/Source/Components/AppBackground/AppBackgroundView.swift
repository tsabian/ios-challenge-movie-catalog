//
//  AppBackgroundView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

struct AppBackgroundView<Content: View>: View {
  @ViewBuilder let content: Content

  var body: some View {
    ZStack {
      Color.accentColor.ignoresSafeArea()
      content
    }
  }
}

#Preview {
  AppBackgroundView {
    VStack {
      Text("Hello, World!")
    }
  }
}
