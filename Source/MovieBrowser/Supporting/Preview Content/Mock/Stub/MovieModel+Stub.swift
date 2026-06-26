//
//  MovieModel+Stub.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 31/05/26.
//

extension MovieModel {
  static func mock(id: Int = 1,
                   title: String = "O Justiceiro: Uma Última Morte",
                   posterPath: String? = "/ppRmgI2MbEOADvKKvlNoRJHPXOT.jpg",
                   backdropPath: String? = "/qO55CD8tgVL1T4WKn6zYFFiD6lL.jpg",
                   rank: Int = 1) -> Self {
    MovieModel(id: id,
               title: title,
               posterPath: posterPath,
               backdropPath: backdropPath,
               rank: rank)
  }
}

extension [MovieModel] {
  static func mock(type: MovieCategory = .topRated) -> Self {
    MovieCatalogModel.mock(type: type).movies
  }
}
