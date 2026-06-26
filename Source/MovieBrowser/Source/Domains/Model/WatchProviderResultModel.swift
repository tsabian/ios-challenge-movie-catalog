//
//  WatchProviderResultModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

struct WatchProviderResultModel {
  let link: String
  let flatrate: [WatchProviderModel]?
  let rent: [WatchProviderModel]?
  let buy: [WatchProviderModel]?
  let free: [WatchProviderModel]?
  let ads: [WatchProviderModel]?
}
