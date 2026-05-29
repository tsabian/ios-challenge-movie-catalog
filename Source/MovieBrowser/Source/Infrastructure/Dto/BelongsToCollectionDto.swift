//
//  BelongsToCollectionDto.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

struct BelongsToCollectionDto: Decodable {
  let id: Int
  let name: String
  let posterPath: String?
  let backdropPath: String?

  enum CodingKeys: String, CodingKey {
    case id, name
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
  }
}
