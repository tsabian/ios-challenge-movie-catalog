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
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  private let appContainer = AppContainer()

  var body: some Scene {
    WindowGroup {
      AppBackgroundView {
        RootView(appContainer: appContainer)
      }
      .tint(Color.accentColor)
    }
  }
}
