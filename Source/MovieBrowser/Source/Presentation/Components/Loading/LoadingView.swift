//
//  LoadingView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 30/05/26.
//

import Combine
import SwiftUI

struct LoadingView: View {
  @State private var quantidadePontos = 0
  let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

  var body: some View {
    VStack {
      HStack(spacing: 0) {
        Text("\(.loading)")
        Text(String(repeating: ".", count: quantidadePontos))
          .frame(width: 20, alignment: .leading)
      }
      .font(MovieBrowserFontsStyle.body.bold())
      .onReceive(timer) { _ in
        withAnimation(.easeInOut(duration: 0.2)) {
          if quantidadePontos < 3 {
            quantidadePontos += 1
          } else {
            quantidadePontos = 0
          }
        }
      }
    }
  }
}

#Preview {
  LoadingView()
}
