//
//  MovieCatalogModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 30/05/26.
//

struct MovieCatalogModel {
  let page: Int
  let movies: [MovieModel]
  let totalPages, totalResults: Int
}
