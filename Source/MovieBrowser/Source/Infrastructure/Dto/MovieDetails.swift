//
//  MovieDetails.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

import SwiftData

@Model
final class MovieDetails {
  @Attribute(.unique) var id: Int
  var title: String
  var originalTitle: String
  var releaseDate: String
  var runtime: Int
  var genre: String
  var tagLine: String
  var overview: String
  var backdropPath: String?
  var posterPath: String?
  var rankAverage: Double
  var watched: Bool

  init(
    id: Int,
    title: String,
    originalTitle: String,
    releaseDate: String,
    runtime: Int,
    genre: String,
    tagLine: String,
    overview: String,
    backdropPath: String? = nil,
    posterPath: String? = nil,
    rankAverage: Double,
    watched: Bool
  ) {
    self.id = id
    self.title = title
    self.originalTitle = originalTitle
    self.releaseDate = releaseDate
    self.runtime = runtime
    self.genre = genre
    self.tagLine = tagLine
    self.overview = overview
    self.backdropPath = backdropPath
    self.posterPath = posterPath
    self.rankAverage = rankAverage
    self.watched = watched
  }
}
