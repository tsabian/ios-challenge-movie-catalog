//
//  WatchListView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 24/05/26.
//

import SwiftUI

struct WatchListView: View {
  var body: some View {
    VStack {
      emptyState()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding()
    .ignoresSafeArea()
    .background {
      Color.accentColor.ignoresSafeArea()
    }
  }

  private func emptyState() -> some View {
    AlternativeFlowStateView(title: String(localized: .thereIsNoMovieYet),
                             message: String(localized: .noResultsMessage),
                             imageName: .folder)
  }
}

#Preview {
  WatchListView()
}
