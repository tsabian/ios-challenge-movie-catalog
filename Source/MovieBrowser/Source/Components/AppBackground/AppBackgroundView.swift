//
//  AppBackgroundView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

struct AppBackgroundView: View {
  @Environment(\.appContainer) private var appContainer: AppContainer

  let pathURLString: String

  var body: some View {
    ZStack {
      RemotePosterView(viewModel: appContainer.viewModelFactory.makeRemotePoster(),
                       pathURLString: pathURLString,
                       width: .infinity,
                       height: .infinity)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scaledToFill()
        .blur(radius: 10)
        .zIndex(0)

      GeometryReader { _ in
        LinearGradient(colors: [
          .accentColor.opacity(0.2),
          .accentColor.opacity(0.9865625)
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
