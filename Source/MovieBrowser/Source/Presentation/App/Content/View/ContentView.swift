//
//  ContentView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/05/26.
//

import SwiftData
import SwiftUI

enum AppTab: Hashable {
  case home
  case search
  case whatchList
}

struct ContentView: View {
  @State private var selectedTab: AppTab = .home
  @State private var searchQuery = ""
  @Environment(\.appContainer) private var container: AppContainer

  var body: some View {
    TabView(selection: $selectedTab) {
      HomeView(viewModel: container.viewModelFactory.makeHome(),
               openSearch: searchHandle)
        .tabItem {
          Image(systemName: "house.fill")
          Text(.home)
        }.tag(AppTab.home)

      SearchView(viewModel: container.viewModelFactory.makeSearch(),
                 query: $searchQuery)
        .tabItem {
          Image(systemName: "magnifyingglass")
          Text(.search)
        }
        .tag(AppTab.search)

      WatchListView()
        .tabItem {
          Image(systemName: "bookmark.fill")
          Text(.watchList)
        }
        .tag(AppTab.whatchList)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  private func searchHandle(query: String) {
    searchQuery = query
    selectedTab = .search
  }
}

#Preview {
  ContentView()
}
