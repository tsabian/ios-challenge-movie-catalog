//
//  RemotePosterViewModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Combine
import SwiftUI

enum RemotePosterState {
  case idle
  case loading
  case loaded(image: UIImage)
  case failed
}

final class RemotePosterViewModel: RemotePosterViewModelProtocol {
  @Published private(set) var state: RemotePosterState = .idle
  private let useCase: FetchRemoteImageUseCaseProtocol

  init(useCase: FetchRemoteImageUseCaseProtocol) {
    self.useCase = useCase
  }

  func load(from pathURLString: String) async {
    guard !pathURLString.isEmpty else {
      state = .failed
      return
    }
    state = .loading
    do {
      let image = try await useCase.fetchImage(from: pathURLString, withSize: .small)
      state = .loaded(image: image)
    } catch {
      state = .failed
    }
  }
}
