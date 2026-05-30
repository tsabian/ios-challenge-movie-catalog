//
//  CastCatalogModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

struct CastCatalogModel: Identifiable, Hashable {
  let id: Int
  let cast, crew: [CastModel]
}
