//
//  SearchRepositoryDependencies.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 19/06/26.
//

import Core

struct SearchRepositoryDependencies {
  let apiClient: ApiClientProtocol
  let apiKey: String
  let language: String?
  let region: String?
  let includeAdult: Bool
  let searchMovieAdapter: SearchMovieAdapter
}
