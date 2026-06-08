//
//  MovieAdapter.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

struct MovieAdapter {
  func adapt(dto: MovieCatalogDto) -> MovieCatalogModel {
    MovieCatalogModel(page: dto.page,
                      movies: dto.results.enumerated().compactMap(adaptMovie),
                      totalPages: dto.totalPages,
                      totalResults: dto.totalResults)
  }

  func adaptMovie(index: Int, dto: MovieDto) -> MovieModel {
    MovieModel(id: dto.id,
               title: dto.title,
               posterPath: dto.posterPath,
               backdropPath: dto.backdropPath,
               rank: index + 1)
  }
}
