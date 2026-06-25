//
//  RemotePosterView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

enum RemotePosterState {
  case idle
  case loading
  case loaded(image: UIImage)
  case failed
}

struct RemotePosterView: View {
  @Environment(\.appContainer) private var appContainer
  @State private var state: RemotePosterState

  private let pathURLString: String?
  private let size: TMDBImageSize
  private let imageService: ImageLoadingServiceProtocol?

  init(pathURLString: String?,
       size: TMDBImageSize = .medium,
       imageService: ImageLoadingServiceProtocol? = nil,
       initialState: RemotePosterState = .idle) {
    self.pathURLString = pathURLString
    self.size = size
    self.imageService = imageService
    _state = State(initialValue: initialState)
  }

  var body: some View {
    content
      .task(id: cacheKey) {
        await load()
      }
  }

  private var resolvedImageService: ImageLoadingServiceProtocol {
    imageService ?? appContainer.viewModelFactory.imageLoadingService
  }

  private var cacheKey: String {
    "\(size.rawValue):\(pathURLString ?? "")"
  }

  @ViewBuilder
  private var content: some View {
    switch state {
    case .idle, .loading:
      Rectangle()
        .fill(Color.accentGray.opacity(0.3))
        .shimmer(isActive: true)
        .redacted(reason: .placeholder)
    case let .loaded(image):
      Image(uiImage: image)
        .resizable()
        .scaledToFit()
    case .failed:
      Rectangle()
        .fill(Color.accentGray.opacity(0.3))
        .overlay {
          Image(systemName: "photo")
            .foregroundStyle(.white.opacity(0.7))
        }
    }
  }

  @MainActor
  private func load() async {
    guard let pathURLString, !pathURLString.isEmpty else {
      state = .failed
      return
    }

    state = .loading

    do {
      let image = try await resolvedImageService.fetchImage(from: pathURLString,
                                                            withSize: size)
      try Task.checkCancellation()
      state = .loaded(image: image)
    } catch is CancellationError {
      return
    } catch {
      state = .failed
    }
  }
}

private struct PreviewImageService: ImageLoadingServiceProtocol {
  func fetchImage(from _: String, withSize _: TMDBImageSize) async throws -> UIImage {
    UIImage(named: "poster-w185-01") ?? UIImage()
  }
}

#Preview {
  RemotePosterView(
    pathURLString: "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
    imageService: PreviewImageService()
  )
}
