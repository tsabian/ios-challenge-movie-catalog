//
//  MovieWatchProvidersDto.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 22/06/26.
//

struct MovieWatchProvidersDto: Decodable {
  let id: Int
  let results: [String: MovieWatchProviderResultDto]
}
