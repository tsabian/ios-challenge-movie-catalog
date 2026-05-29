//
//  MovieAdapter.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

struct MovieAdapter {
  func adapt(dto movies: [MovieDto]) -> [HomeMovieModel] {
    movies.enumerated()
      .compactMap { index, element in
        HomeMovieModel(id: element.id,
                       title: element.title,
                       posterPath: element.posterPath,
                       rank: index + 1)
      }
  }
}
