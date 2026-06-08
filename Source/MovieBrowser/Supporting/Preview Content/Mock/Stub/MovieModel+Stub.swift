//
//  MovieModel+Stub.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 31/05/26.
//

extension [MovieModel] {
  static func mock(type: MovieCategory = .topRated) -> Self {
    MovieCatalogModel.mock(type: type).movies
  }
}
