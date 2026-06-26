//
//  WatchProvidersDto.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 22/06/26.
//

struct WatchProvidersDto: Decodable {
  let id: Int
  let results: [String: WatchProviderResultDto]
}
