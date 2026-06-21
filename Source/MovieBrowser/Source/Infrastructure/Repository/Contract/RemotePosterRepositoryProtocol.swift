//
//  RemotePosterRepositoryProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import Foundation

protocol RemotePosterRepositoryProtocol {
  func fetch(path: String, size: TMDBImageSize) async throws -> Data
}
