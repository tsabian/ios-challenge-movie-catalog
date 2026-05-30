//
//  DetailInfo.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import SwiftUI

enum DetailInfo: String, CaseIterable {
  case about
  case reviews
  case cast

  var title: String {
    switch self {
    case .about: String(localized: .aboutMovie)
    case .reviews: String(localized: .reviews)
    case .cast: String(localized: .cast)
    }
  }
}
