//
//  ViewModelContainer.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import SwiftUI

extension EnvironmentValues {
  @Entry var homeViewModel: HomeViewModel = HomeContainerBuilder.build()
}
