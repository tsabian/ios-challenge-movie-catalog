//
//  ProductionCompanyDto.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

struct ProductionCompanyDto: Decodable {
  let id: Int
  let logoPath: String?
  let name, originCountry: String

  enum CodingKeys: String, CodingKey {
    case id
    case logoPath = "logo_path"
    case name
    case originCountry = "origin_country"
  }
}
