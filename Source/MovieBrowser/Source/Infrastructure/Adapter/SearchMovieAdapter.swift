//
//  SearchMovieAdapter.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/06/26.
//

struct SearchMovieAdapter {
  func adapt(dto: MovieCatalogDto) -> SearchMovieCatalogModel {
    SearchMovieCatalogModel(page: dto.page,
                            movies: dto.results.map(adaptMovie),
                            totalPages: dto.totalPages,
                            totalResults: dto.totalResults)
  }

  private func adaptMovie(dto: MovieDto) -> SearchMovieResultModel {
    SearchMovieResultModel(
      id: dto.id,
      title: dto.title,
      posterPath: dto.posterPath,
      releaseDate: dto.releaseDate,
      runtime: 0,
      genre: dto.genreIDS.first,
      rankAverage: dto.voteAverage
    )
  }
}
