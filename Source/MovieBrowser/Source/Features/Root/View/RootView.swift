//
//  RootView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 24/05/26.
//

import SwiftData
import SwiftUI

struct RootView: View {
  private let appContainer: AppContainer
  @State private var isShowingSplash = true

  init(appContainer: AppContainer = AppContainer()) {
    self.appContainer = appContainer
  }

  var body: some View {
    ZStack {
      if isShowingSplash {
        SplashScreenView()
      } else {
        ContentView(appContainer: appContainer)
      }
    }
    .animation(.easeInOut(duration: 0.5), value: isShowingSplash)
    .task {
      await startApp()
    }
  }

  private func startApp() async {
    try? await Task.sleep(nanoseconds: 1_500_000_000)
    isShowingSplash = false
  }
}

#Preview {
  RootView()
}
