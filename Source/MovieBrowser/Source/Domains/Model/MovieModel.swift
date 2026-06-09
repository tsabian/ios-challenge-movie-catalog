//
//  MovieModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

struct MovieModel: Identifiable, Hashable {
  let id: Int
  let title: String
  let posterPath: String
  let backdropPath: String
  let rank: Int
}
