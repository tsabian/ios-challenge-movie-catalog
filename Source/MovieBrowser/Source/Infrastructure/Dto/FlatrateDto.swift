//
//  FlatrateDto.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 22/06/26.
//

struct FlatrateDto: Decodable {
  let logoPath: String?
  let providerID: Int
  let providerName: String
  let displayPriority: Int

  enum CodingKeys: String, CodingKey {
    case logoPath = "logo_path"
    case providerID = "provider_id"
    case providerName = "provider_name"
    case displayPriority = "display_priority"
  }
}
