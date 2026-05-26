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
  var body: some Scene {
    WindowGroup {
      AppBackgroundView {
        RootView()
      }
      .tint(Color.accentColor)
    }
  }
}
