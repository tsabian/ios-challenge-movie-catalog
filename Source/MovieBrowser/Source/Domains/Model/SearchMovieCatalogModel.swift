//
//  SearchMovieCatalogModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/06/26.
//

struct SearchMovieCatalogModel {
  let page: Int
  let movies: [SearchMovieResultModel]
  let totalPages, totalResults: Int
}
