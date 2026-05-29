//
//  Environment+Values.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import SwiftUI

private struct ContainerKeys: @preconcurrency EnvironmentKey {
  static let defaultValue: AppContainer = .live
}

extension EnvironmentValues {
  @Entry var appContainer: AppContainer = .live
}
