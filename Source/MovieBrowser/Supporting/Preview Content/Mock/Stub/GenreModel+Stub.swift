//
//  GenreModel+Stub.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/06/26.
//

extension GenreModel {
  static func mock(id: Int = 28, name: String = "Ação") -> Self {
    .init(id: id,
          name: name)
  }
}

extension [GenreModel] {
  static func mock() -> Self {
    do {
      let dto = try PreviewDataFactory.shared.makeGenre()
      return GenreAdapter().adapt(dto: dto)
    } catch {
      fatalError()
    }
  }
}
