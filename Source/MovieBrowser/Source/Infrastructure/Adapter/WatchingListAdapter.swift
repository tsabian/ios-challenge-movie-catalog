//
//  WatchingListAdapter.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

struct WatchingListAdapter {
  func adapt(entity: MovieDetails) -> MovieDetailsModel {
    .init(
      id: entity.id,
      title: entity.title,
      originalTitle: entity.originalTitle,
      releaseDate: entity.releaseDate,
      runtime: entity.runtime,
      genre: entity.genre,
      tagLine: entity.tagLine,
      overview: entity.overview,
      backdropPath: entity.backdropPath,
      posterPath: entity.posterPath,
      rankAverage: entity.rankAverage,
      watched: entity.watched
    )
  }

  func reverse(model: MovieDetailsModel) -> MovieDetails {
    .init(
      id: model.id,
      title: model.title,
      originalTitle: model.originalTitle,
      releaseDate: model.releaseDate,
      runtime: model.runtime,
      genre: model.genre,
      tagLine: model.tagLine,
      overview: model.overview,
      backdropPath: model.backdropPath,
      posterPath: model.posterPath,
      rankAverage: model.rankAverage,
      watched: model.watched
    )
  }
}
