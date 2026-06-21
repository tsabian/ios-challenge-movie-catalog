//
//  CastView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import SwiftUI

struct CastView: View {
  @Environment(\.appContainer) private var appContainer

  private let columns = [
    GridItem(.flexible()),
    GridItem(.flexible())
  ]

  let isLoading: Bool
  let cast: [CastModel]
  let isPopularityHidden: Bool = true

  var body: some View {
    if isLoading {
      LoadingView()
    } else {
      if cast.isEmpty {
        CollectionEmptyStateView(title: String(localized: .noCast),
                                 message: String(localized: .noResultsMessage))
      } else {
        content
      }
    }
  }

  private var content: some View {
    LazyVGrid(columns: columns) {
      ForEach(cast) { element in
        castRow(for: element)
          .padding()
      }
    }
  }

  private func castRow(for element: CastModel) -> some View {
    VStack(spacing: 2) {
      if let profilePath = element.profilePath {
        ZStack {
          RemotePosterView(
            viewModel: appContainer.viewModelFactory.makeRemotePoster(),
            pathURLString: profilePath)
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: 100, height: 100)

          Text(element.popularityText)
            .font(MovieBrowserFontsStyle.footnote)
            .foregroundStyle(.white)
            .frame(width: 32, height: 32)
            .background(Circle().fill(Color.red))
            .clipShape(Circle())
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .offset(x: -30, y: 0)
            .opacity(isPopularityHidden ? 0 : 1)
        }
      } else {
        Image("user-avatar")
          .resizable()
          .scaledToFit()
          .clipShape(Circle())
          .frame(width: 100, height: 100)
      }
      Text(element.name)
        .font(MovieBrowserFontsStyle.footnote)
        .foregroundStyle(.secondaryOrange)
        .lineLimit(1)

      if let char = element.character {
        Text(char)
          .font(MovieBrowserFontsStyle.caption2)
          .foregroundStyle(.white)
          .lineLimit(1)
      }
    }
  }
}

#Preview {
  CastView(isLoading: false, cast: .mock())
}
