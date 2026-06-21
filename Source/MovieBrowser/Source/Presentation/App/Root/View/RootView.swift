//
//  RootView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 24/05/26.
//

import SwiftData
import SwiftUI

struct RootView: View {
  @State private var isShowingSplash = true

  var body: some View {
    ZStack {
      if isShowingSplash {
        SplashScreenView()
      } else {
        ContentView()
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .ignoresSafeArea()
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
