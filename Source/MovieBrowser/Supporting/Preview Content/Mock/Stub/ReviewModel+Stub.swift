//
//  ReviewModel+Stub.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

extension ReviewModel {
  static func mock() -> Self {
    do {
      let dto = try PreviewDataFactory.shared.makeMovieReviews()
      return ReviewAdapter().adapt(dto: dto)
    } catch {
      fatalError()
    }
  }
}
