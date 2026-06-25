//
//  MovieDetailBuilderDependencies.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 22/06/26.
//

import Core

struct MovieDetailBuilderDependencies {
  let apiClient: ApiClientProtocol
  let apiKey: String
  let language: String?
  let region: String?
  let movie: MovieModel
  let imageService: ImageLoadingServiceProtocol
  let hostUrlString: String
}
