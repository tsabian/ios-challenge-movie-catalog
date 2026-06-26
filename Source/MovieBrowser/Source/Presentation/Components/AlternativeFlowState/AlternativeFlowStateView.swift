//
//  AlternativeFlowStateView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 26/05/26.
//

import SwiftUI

struct AlternativeFlowStateView: View {
  enum IconType: String {
    case error
    case noResults = "no-results"
    case folder
    case problem
    case warning
    case wrong
  }

  private let title: String
  private let message: String
  private let imageName: IconType

  init(title: String,
       message: String,
       imageName: IconType = .noResults) {
    self.title = title
    self.message = message
    self.imageName = imageName
  }

  var body: some View {
    VStack(spacing: 8) {
      Image(imageName.rawValue)
        .resizable()
        .scaledToFill()
        .frame(width: 76, height: 76)

      Text(title)
        .font(MovieBrowserFontsStyle.title)
        .multilineTextAlignment(.leading)
        .frame(width: 250)

      Text(message)
        .font(MovieBrowserFontsStyle.body)
        .multilineTextAlignment(.center)
        .foregroundColor(.accentLightGray)
        .frame(width: 250)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding()
  }
}

#Preview {
  AlternativeFlowStateView(title: "title",
                           message: "message")
}
