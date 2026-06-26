//
//  MovieDetailsModel+Stub.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

extension MovieDetailsModel {
  static func mock() -> Self {
    do {
      let dto = try PreviewDataFactory.shared.makeMovieDetail()
      return MovieDetailAdapter().adapt(dto: dto)
    } catch {
      fatalError()
    }
  }
}
