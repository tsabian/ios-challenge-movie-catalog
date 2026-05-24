//
//  AppEnvironment.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/05/26.
//

import Foundation

struct AppEnvironment {
  private let bundle: Bundle

  static var current = AppEnvironment(bundle: .main)

  var sslPinningKey: String {
    guard let key = bundle.object(forInfoDictionaryKey: "TMDB_SSL_PINNING_KEY") as? String,
          !key.isEmpty
    else {
      fatalError("❌ Erro: Chave TMDB_SSL_PINNING_KEY não encontrada no Info.plist.")
    }
    return key
  }

  var apiKey: String {
    guard let key = bundle.object(forInfoDictionaryKey: "TMDB_API_KEY") as? String,
          !key.isEmpty
    else {
      fatalError("❌ Erro: Chave TMDB_API_KEY não encontrada no Info.plist.")
    }
    return key
  }

  var apiToken: String {
    guard let key = bundle.object(forInfoDictionaryKey: "TMDB_API_TOKEN") as? String,
          !key.isEmpty
    else {
      fatalError("❌ Erro: Chave TMDB_API_TOKEN não encontrada no Info.plist.")
    }
    return key
  }
}
