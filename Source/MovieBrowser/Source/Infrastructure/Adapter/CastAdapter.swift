//
//  CastAdapter.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import Foundation

struct CastAdapter {
  func adapt(dto: CastingDto) -> CastCatalogModel {
    CastCatalogModel(
      id: dto.id,
      cast: dto.cast.compactMap(adaptCast(dto:)),
      crew: dto.crew.compactMap(adaptCast(dto:))
    )
  }

  private func adaptCast(dto: CastDto) -> CastModel? {
    CastModel(
      gender: dto.gender,
      id: dto.id,
      knownForDepartment: dto.knownForDepartment.rawValue,
      name: dto.name,
      originalName: dto.originalName,
      popularity: String(format: "%.1f", dto.popularity),
      profilePath: dto.profilePath,
      castID: dto.castID,
      character: dto.character,
      creditID: dto.creditID,
      order: dto.order,
      department: dto.department?.rawValue,
      job: dto.job
    )
  }
}
