//
//  MontserratFont.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

enum MontserratFont: String {
  case bold = "Montserrat-Bold"
  case regular = "Montserrat-Regular"
  case light = "Montserrat-Light"

  func size(_ size: CGFloat, relativeTo style: Font.TextStyle = .body) -> Font {
    .custom(rawValue, size: size, relativeTo: style)
  }
}
