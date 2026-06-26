//
//  ProductionCountryDto.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

struct ProductionCountryDto: Decodable {
  let iso31661, name: String

  enum CodingKeys: String, CodingKey {
    case iso31661 = "iso_3166_1"
    case name
  }
}
