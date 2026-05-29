//
//  ContentView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/05/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
  @Environment(\.appContainer) private var container: AppContainer

  var body: some View {
    TabView {
      HomeView(viewModel: container.viewModelFactory.makeHome())
        .tabItem {
          Image(systemName: "house.fill")
          Text(.home)
        }
      SearchView()
        .tabItem {
          Image(systemName: "magnifyingglass")
          Text(.search)
        }
      WatchListView()
        .tabItem {
          Image(systemName: "bookmark.fill")
          Text(.watchList)
        }
    }
    .toolbarBackground(.indigo, for: .tabBar)
    .toolbarBackground(.visible, for: .tabBar)
    .toolbarBackground(.ultraThinMaterial, for: .tabBar)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

#Preview {
  ContentView()
}
