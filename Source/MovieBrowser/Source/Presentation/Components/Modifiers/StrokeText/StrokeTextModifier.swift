//
//  StrokeTextModifier.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

struct StrokeTextModifier: ViewModifier {
  let strokeColor: Color
  let strokeWidth: CGFloat
  let fillColor: Color

  func body(content: Content) -> some View {
    ZStack {
      ZStack {
        content.offset(x: strokeWidth, y: strokeWidth)
        content.offset(x: -strokeWidth, y: -strokeWidth)
        content.offset(x: -strokeWidth, y: strokeWidth)
        content.offset(x: strokeWidth, y: -strokeWidth)
      }
      .foregroundColor(strokeColor)
      content
        .foregroundStyle(fillColor)
    }
  }
}

extension View {
  func outline(color: Color, width: CGFloat, fillColor: Color = .clear) -> some View {
    modifier(StrokeTextModifier(strokeColor: color,
                                strokeWidth: width,
                                fillColor: fillColor))
  }
}

#Preview {
  Text("SwiftUI")
    .font(MontserratFont.bold.size(98))
    .outline(color: Color.accentBlue,
             width: 1,
             fillColor: Color.accentColor)
}
