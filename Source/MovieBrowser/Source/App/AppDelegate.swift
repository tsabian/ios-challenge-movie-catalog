//
//  AppDelegate.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 24/05/26.
//

import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
  func application(
    _: UIApplication,
    didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor.blue
    appearance.shadowColor = nil // Remove linha cinza superior se quiser
    appearance.shadowImage = nil
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance

    return true
  }
}
