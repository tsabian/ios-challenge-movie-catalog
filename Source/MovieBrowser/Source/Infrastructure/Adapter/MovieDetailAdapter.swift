//
//  MovieDetailAdapter.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import Core
import SwiftUI

struct MovieDetailAdapter {
  func adapt(dto: MovieDetailDto) -> MovieDetailsModel {
    MovieDetailsModel(
      id: dto.id,
      title: dto.title,
      originalTitle: dto.originalTitle,
      releaseDate: dto.releaseDate,
      runtime: dto.runtime,
      genre: dto.genres.first?.name ?? "",
      tagLine: dto.tagline,
      overview: dto.overview,
      backdropPath: dto.backdropPath,
      posterPath: dto.posterPath,
      rankAverage: dto.voteAverage
    )
  }
}
