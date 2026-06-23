//
//  MovieWatchProviderResultDto.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 22/06/26.
//

struct MovieWatchProviderResultDto: Decodable {
  let link: String
  let flatrate: [FlatrateDto]
}
