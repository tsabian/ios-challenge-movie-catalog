//
//  SplashScreenView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 24/05/26.
//

import SwiftUI

struct SplashScreenView: View {
  @State private var scale: CGFloat = 0.8
  @State private var opacity: Double = 0.5

  var body: some View {
    VStack(spacing: 12) {
      LoadingView()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background {
      Color.accentColor.ignoresSafeArea()
    }
    .ignoresSafeArea()
    .onAppear {
      withAnimation(.easeIn(duration: 0.8).repeatForever(autoreverses: true)) {
        scale = 1.0
        opacity = 1.0
      }
    }
  }
}

#Preview {
  SplashScreenView()
}
