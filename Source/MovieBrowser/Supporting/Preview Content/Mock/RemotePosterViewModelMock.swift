//
//  RemotePosterViewModelMock.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Combine
import SwiftUI

final class RemotePosterViewModelMock: RemotePosterViewModelProtocol {
  @Published var state: RemotePosterState = .idle

  func load(from _: String, size _: TMDBImageSize) async {}
}
