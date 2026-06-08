//
//  MovieCategory+title.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 08/06/26.
//

import SwiftUI

extension MovieCategory {
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
