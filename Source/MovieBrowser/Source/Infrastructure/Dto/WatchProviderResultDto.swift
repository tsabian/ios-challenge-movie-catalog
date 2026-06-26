//
//  WatchProviderResultDto.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 22/06/26.
//

struct WatchProviderResultDto: Decodable {
  let link: String
  let flatrate: [WatchProviderDto]?
  let rent: [WatchProviderDto]?
  let buy: [WatchProviderDto]?
  let free: [WatchProviderDto]?
  let ads: [WatchProviderDto]?
}
