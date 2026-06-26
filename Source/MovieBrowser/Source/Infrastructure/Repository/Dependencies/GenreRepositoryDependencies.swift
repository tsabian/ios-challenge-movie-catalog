//
//  GenreRepositoryDependencies.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/06/26.
//

import Core
import Foundation

struct GenreRepositoryDependencies {
  let apiKey: String
  let language: String?
  let genreAdapter: GenreAdapter
  let genreProvider: ResourceCacheProvider<NSData>
}
