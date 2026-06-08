//
//  DetailAdapter.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import Core
import SwiftUI

struct DetailAdapter {
  func adapt(dto: MovieDetailDto) -> MovieDetailsModel {
    MovieDetailsModel(
      id: dto.id,
      title: dto.title,
      originalTitle: dto.originalTitle,
      releaseYear: dto.releaseDate.getYear() ?? 0,
      runtime: dto.runtime,
      genre: dto.genres.first?.name ?? "",
      overview: dto.overview,
      backdropPath: dto.backdropPath,
      posterPath: dto.posterPath,
      rankAverage: dto.voteAverage
    )
  }
}
