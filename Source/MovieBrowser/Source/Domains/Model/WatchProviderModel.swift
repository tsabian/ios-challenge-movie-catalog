//
//  WatchProviderModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

struct WatchProviderModel: Identifiable {
  var id: Int {
    providerID
  }

  let logoPath: String?
  let providerID: Int
  let providerName: String
  let displayPriority: Int
}
