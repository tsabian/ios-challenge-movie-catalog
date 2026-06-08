//
//  MovieCatalogModel+Stub.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 31/05/26.
//

extension MovieCatalogModel {
  static func mock(type: MovieCategory = .topRated) -> Self {
    do {
      let dto = try PreviewDataFactory.shared.makeMovieCatalog(for: type)
      return MovieAdapter().adapt(dto: dto)
    } catch {
      fatalError()
    }
  }
}
