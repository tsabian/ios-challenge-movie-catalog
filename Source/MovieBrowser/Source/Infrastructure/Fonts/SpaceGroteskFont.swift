//
//  SpaceGroteskFont.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

enum SpaceGroteskFont: String {
  case bold = "SpaceGrotesk-Bold"
  case regular = "SpaceGrotesk-Regular"
  case light = "SpaceGrotesk-Light"

  func size(_ size: CGFloat, relativeTo style: Font.TextStyle = .body) -> Font {
    .custom(rawValue, size: size, relativeTo: style)
  }
}
