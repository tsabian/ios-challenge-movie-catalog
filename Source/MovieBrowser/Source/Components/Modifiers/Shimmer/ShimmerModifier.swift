//
//  ShimmerModifier.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import SwiftUI

struct ShimmerModifier: ViewModifier {
  @State private var phase: CGFloat = 0
  private let doubleWith = 2.0
  func body(content: Content) -> some View {
    content
      .overlay(
        GeometryReader { geo in
          LinearGradient(
            colors: [
              .clear,
              .white.opacity(0.3),
              .clear
            ],
            startPoint: .leading,
            endPoint: .trailing
          )
          .frame(width: geo.size.width)
          .offset(x: -geo.size.width + (geo.size.width * doubleWith * phase))
        }
      )
      .mask(content)
      .onAppear {
        withAnimation(
          .smooth(duration: 1.1)
            .repeatForever(autoreverses: false)
        ) {
          phase = 1
        }
      }
  }
}

extension View {
  @ViewBuilder
  func shimmer(isActive: Bool) -> some View {
    if isActive {
      modifier(ShimmerModifier())
    } else {
      self
    }
  }
}
