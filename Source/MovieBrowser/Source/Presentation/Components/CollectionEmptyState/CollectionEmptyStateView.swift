//
//  CollectionEmptyStateView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 26/05/26.
//

import SwiftUI

struct CollectionEmptyStateView: View {
  let title: String
  let message: String

  var body: some View {
    VStack(spacing: 8) {
      Image("no-results")
        .resizable()
        .scaledToFill()
        .frame(width: 100, height: 100)
      Text(title)
        .font(MovieBrowserFontsStyle.title)
        .multilineTextAlignment(.leading)
        .frame(width: 250)
      Text(message)
        .font(MovieBrowserFontsStyle.body)
        .multilineTextAlignment(.center)
        .foregroundColor(.accentLightGray)
        .frame(width: 250)
    }
    .frame(minWidth: nil,
           maxWidth: .infinity,
           minHeight: nil,
           maxHeight: .infinity)
    .padding()
  }
}

#Preview {
  CollectionEmptyStateView(title: "title", message: "message")
}
