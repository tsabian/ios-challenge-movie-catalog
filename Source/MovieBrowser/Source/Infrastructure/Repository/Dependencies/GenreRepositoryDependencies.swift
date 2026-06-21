//
//  GenreRepositoryDependencies.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/06/26.
//

import Core

struct GenreRepositoryDependencies {
  let apiClient: ApiClientProtocol
  let apiKey: String
  let language: String?
  let genreAdapter: GenreAdapter
}
