//
//  ContentView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/05/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
  private let appContainer: AppContainer

  init(appContainer: AppContainer = AppContainer()) {
    self.appContainer = appContainer
  }

  var body: some View {
    TabView {
      HomeView(viewModel: appContainer.makeHomeViewModel())
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
  }
}

#Preview {
  ContentView()
}
