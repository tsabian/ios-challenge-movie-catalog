//
//  MovieAdapter.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

struct MovieAdapter {
  func adapt(dto movies: [MovieDto]) -> [MovieModel] {
    movies.enumerated()
      .compactMap { index, element in
        MovieModel(id: element.id,
                   title: element.title,
                   posterPath: element.posterPath,
                   rank: index + 1)
      }
  }
}
