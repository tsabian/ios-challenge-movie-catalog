//
//  MovieBrowserFonts.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

struct MovieBrowserFontsStyle: RawRepresentable {
  var rawValue: Font

  static let title: Font = SpaceGroteskFont.regular.size(25)
  static let subTitle: Font = SpaceGroteskFont.regular.size(19)
  static let body: Font = SpaceGroteskFont.regular.size(16)
  static let footnote: Font = SpaceGroteskFont.regular.size(14)
  static let caption: Font = SpaceGroteskFont.regular.size(12)
  static let caption2: Font = SpaceGroteskFont.regular.size(11)
  static let caption3: Font = SpaceGroteskFont.regular.size(10)
  static let caption4: Font = SpaceGroteskFont.regular.size(9)
  static let CardRanking: Font = MontserratFont.bold.size(98)
}
