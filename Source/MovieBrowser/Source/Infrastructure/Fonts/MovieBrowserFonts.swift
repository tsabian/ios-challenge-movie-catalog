//
//  MovieBrowserFonts.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

struct MovieBrowserFontsStyle: RawRepresentable {
  var rawValue: Font

  static var title: Font = SpaceGroteskFont.regular.size(25)
  static var subTitle: Font = SpaceGroteskFont.regular.size(19)
  static var body: Font = SpaceGroteskFont.regular.size(16)
  static var footnote: Font = SpaceGroteskFont.regular.size(14)
  static var caption: Font = SpaceGroteskFont.regular.size(12)
  static var caption2: Font = SpaceGroteskFont.regular.size(11)
  static var caption3: Font = SpaceGroteskFont.regular.size(10)
  static var caption4: Font = SpaceGroteskFont.regular.size(9)

  static var CardRanking: Font = MontserratFont.bold.size(98)
}
