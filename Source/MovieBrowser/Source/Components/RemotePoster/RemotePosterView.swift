//
//  RemotePosterView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

struct RemotePosterView: View {
  let imageURL: String
  let width: CGFloat
  let height: CGFloat

  var body: some View {
    AsyncImage(url: URL(string: imageURL)) { phase in
      switch phase {
      case .empty:
        RoundedRectangle(cornerRadius: 10)
          .fill(Color.accentGray.opacity(0.3))
          .frame(width: width, height: height)
          .shimmer(isActive: true)
          .redacted(reason: .placeholder)
      case let .success(image):
        image
          .resizable()
          .scaledToFit()
          .frame(width: width, height: height)
          .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
      case .failure:
        RoundedRectangle(cornerRadius: 10)
          .fill(Color.accentGray.opacity(0.3))
          .frame(width: width, height: height)
          .overlay {
            Image(systemName: "photo")
              .foregroundStyle(.white.opacity(0.7))
          }
      @unknown default:
        EmptyView()
      }
    }
  }
}

#Preview {
  RemotePosterView(imageURL: "https://image.tmdb.org/t/p/w185/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
                   width: 145.0, height: 235.0)
}
