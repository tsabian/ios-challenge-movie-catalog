//
//  MovieDetailsModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

struct MovieDetailsModel: Identifiable, Hashable {
  let id: Int
  let title: String
  let originalTitle: String
  let releaseDate: String
  let runtime: Int
  let genre: String
  let tagLine: String
  let overview: String
  let backdropPath: String?
  let posterPath: String?
  let rankAverage: Double

  var watched: Bool = false
}
