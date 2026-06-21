//
//  MovieRepositoryDependencies.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 08/06/26.
//

import Core
import Foundation

struct MovieRepositoryDependencies {
  let apiClient: ApiClientProtocol
  let apiKey: String
  let language: String?
  let region: String?
  let movieAdapter: MovieAdapter
  let detailAdapter: MovieDetailAdapter
  let reviewAdapter: ReviewAdapter
  let castAdapter: CastAdapter
}
