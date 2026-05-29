//
//  MovieViewModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

struct HomeMovieModel: Identifiable, Hashable {
  let id: Int
  let title: String
  let posterPath: String
  let rank: Int
}
