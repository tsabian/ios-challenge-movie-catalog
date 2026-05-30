//
//  MovieCategory.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

enum MovieCategory: String, CaseIterable {
  case nowPlaying, upComing, topRated, popular

  var title: String {
    switch self {
    case .nowPlaying:
      String(localized: .nowPlaying)
    case .upComing:
      String(localized: .upComing)
    case .topRated:
      String(localized: .topRated)
    case .popular:
      String(localized: .popular)
    }
  }
}
