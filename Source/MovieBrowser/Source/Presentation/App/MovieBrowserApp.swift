//
//  MovieBrowserApp.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/05/26.
//

import SwiftData
import SwiftUI

@main
struct MovieBrowserApp: App {
  @Environment(\.appContainer) private var appContainer

  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

  var body: some Scene {
    WindowGroup {
      RootView(viewModel: appContainer.viewModelFactory.makeRoot())
        .preferredColorScheme(.dark)
        .environment(\.appContainer, .live)
    }
  }
}
