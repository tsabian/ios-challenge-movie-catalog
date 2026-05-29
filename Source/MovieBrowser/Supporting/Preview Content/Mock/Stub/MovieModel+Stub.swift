//
//  MovieModel+Stub.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

extension [MovieModel] {
  static func mock(type: MovieCategory) -> Self {
    do {
      let dto = try PreviewDataFactory.shared.makeMovieCatalog(for: type)
      return MovieAdapter().adapt(dto: dto.results)
    } catch {
      fatalError()
    }
  }
}
