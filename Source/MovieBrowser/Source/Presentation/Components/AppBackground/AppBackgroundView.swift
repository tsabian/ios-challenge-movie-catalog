//
//  AppBackgroundView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

struct AppBackgroundView: View {
  @Environment(\.appContainer) private var appContainer: AppContainer

  let pathURLString: String?

  var body: some View {
    ZStack {
      if let pathURLString {
        RemotePosterView(viewModel: appContainer.viewModelFactory.makeRemotePoster(),
                         pathURLString: pathURLString)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .scaledToFill()
          .blur(radius: 10)
          .zIndex(0)
      }

      GeometryReader { _ in
        LinearGradient(colors: [
          .accentColor.opacity(0.4),
          .accentColor.opacity(0.9875625)
        ],
        startPoint: .topLeading,
        endPoint: .center)
      }
      .zIndex(3)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .ignoresSafeArea()
  }
}

#Preview {
  AppBackgroundView(pathURLString: "/uIb9Tvae5haF0XcQBaPyufmxbb0.jpg")
}
