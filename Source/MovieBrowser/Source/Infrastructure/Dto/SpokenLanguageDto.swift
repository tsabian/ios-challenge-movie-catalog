//
//  SpokenLanguageDto.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

struct SpokenLanguageDto: Decodable {
  let englishName, iso6391, name: String

  enum CodingKeys: String, CodingKey {
    case englishName = "english_name"
    case iso6391 = "iso_639_1"
    case name
  }
}
