//
//  RemotePosterView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

struct RemotePosterView<ViewModel: RemotePosterViewModelProtocol>: View {
  @StateObject private var viewModel: ViewModel

  let pathURLString: String?
  let size: TMDBImageSize

  init(viewModel: @autoclosure @escaping () -> ViewModel,
       pathURLString: String?,
       size: TMDBImageSize = .medium) {
    _viewModel = StateObject(wrappedValue: viewModel())
    self.pathURLString = pathURLString
    self.size = size
  }

  var body: some View {
    content
      .task(id: pathURLString) {
        await viewModel.load(from: pathURLString, size: size)
      }
  }

  @ViewBuilder
  private var content: some View {
    switch viewModel.state {
    case .idle, .loading:
      Rectangle()
        .fill(Color.accentGray.opacity(0.3))
        .shimmer(isActive: true)
        .redacted(reason: .placeholder)
    case let .loaded(image):
      Image(uiImage: image)
        .resizable()
        .scaledToFill()
    case .failed:
      Rectangle()
        .fill(Color.accentGray.opacity(0.3))
        .overlay {
          Image(systemName: "photo")
            .foregroundStyle(.white.opacity(0.7))
        }
    }
  }
}

#Preview {
  RemotePosterView(
    viewModel: RemotePosterPreviewMockFactory.make(
      state: .loaded(image: UIImage(named: "poster-w185-01") ?? UIImage())
    ),
    pathURLString: "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png")
}
