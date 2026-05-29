//
//  RemotePosterView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

struct RemotePosterView<ViewModel: RemotePosterViewModelProtocol>: View {
  @StateObject private var viewModel: ViewModel

  let pathURLString: String
  let width: CGFloat
  let height: CGFloat

  init(viewModel: @autoclosure @escaping () -> ViewModel,
       pathURLString: String,
       width: CGFloat,
       height: CGFloat) {
    _viewModel = StateObject(wrappedValue: viewModel())
    self.pathURLString = pathURLString
    self.width = width
    self.height = height
  }

  var body: some View {
    content
      .frame(maxWidth: width, maxHeight: height)
      .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
      .task(id: pathURLString) {
        await viewModel.load(from: pathURLString)
      }
  }

  @ViewBuilder
  private var content: some View {
    switch viewModel.state {
    case .idle, .loading:
      RoundedRectangle(cornerRadius: 10)
        .fill(Color.accentGray.opacity(0.3))
        .shimmer(isActive: true)
        .redacted(reason: .placeholder)
    case let .loaded(image):
      Image(uiImage: image)
        .resizable()
        .scaledToFit()
    case .failed:
      RoundedRectangle(cornerRadius: 10)
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
    pathURLString: "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
    width: 145.0,
    height: 235.0
  )
}
