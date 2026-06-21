//
//  SearchMovieCatalogModel+Stub.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/06/26.
//

extension SearchMovieCatalogModel {
  static func mock() -> Self {
    do {
      let dto = try PreviewDataFactory.shared.makeSearch()
      return SearchMovieAdapter().adapt(dto: dto)
    } catch {
      fatalError()
    }
  }
}
