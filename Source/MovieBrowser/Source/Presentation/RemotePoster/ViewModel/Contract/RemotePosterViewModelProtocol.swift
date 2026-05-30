//
//  RemotePosterViewModelProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Combine

protocol RemotePosterViewModelProtocol: ObservableObject {
  var state: RemotePosterState { get }

  func load(from pathURLString: String, size: TMDBImageSize) async
}
