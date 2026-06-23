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
  @Environment(\.appContainer) private var container: AppContainer

  @State private var selectedTab: AppTab = .home
  @State private var searchQuery = ""
  @State private var homeRouter = HomeRouter()
  @State private var searchRouter = SearchRouter()
  @State private var watchListRouter = WatchListRouter()

  var body: some View {
    TabView(selection: $selectedTab) {
      HomeView(viewModel: container.viewModelFactory.makeHome(),
               router: $homeRouter,
               openSearch: searchHandle)
        .tabItem {
          Image(systemName: "house.fill")
          Text(.home)
        }.tag(AppTab.home)

      SearchView(viewModel: container.viewModelFactory.makeSearch(),
                 router: $searchRouter,
                 query: $searchQuery)
        .tabItem {
          Image(systemName: "magnifyingglass")
          Text(.search)
        }
        .tag(AppTab.search)

      WatchListView(viewModel: container.viewModelFactory.makeWatchList(),
                    router: $watchListRouter)
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
