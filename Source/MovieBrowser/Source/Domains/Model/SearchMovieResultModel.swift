//
//  SearchMovieResultModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/06/26.
//

struct SearchMovieResultModel: Identifiable, Hashable {
  let id: Int
  let title: String
  let posterPath: String?
  let releaseDate: String
  let runtime: Int
  let genre: Int?
  let rankAverage: Double
}
