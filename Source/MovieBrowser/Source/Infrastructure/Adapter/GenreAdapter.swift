//
//  GenreAdapter.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/06/26.
//

struct GenreAdapter {
  func adapt(dto: GenreCatalogDto) -> [GenreModel] {
    dto.genres.compactMap(adaptGenre)
  }

  private func adaptGenre(dto: GenreDto) -> GenreModel {
    GenreModel(id: dto.id, name: dto.name)
  }
}
