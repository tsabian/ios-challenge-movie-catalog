//
//  AppEnvironment.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/05/26.
//

import Foundation

enum AppEnvironmentKeys: String {
  case tmdbApiBaseUrl = "TMDB_API_BASE_URL"
  case tmdbImageBaseUrl = "TMDB_IMG_BASE_URL"
  case tmdbApiSslPinningKey = "TMDB_API_SSL_PINNING_KEY"
  case tmdbImageSslPinningKey = "TMDB_IMG_SSL_PINNING_KEY"
  case tmdbApiKey = "TMDB_API_KEY"
  case tmdbApiToken = "TMDB_API_TOKEN"
}

struct AppEnvironment {
  private let bundle: Bundle

  static var current = AppEnvironment(bundle: .main)

  func value(for key: AppEnvironmentKeys) -> String {
    guard let key = bundle.object(forInfoDictionaryKey: key.rawValue) as? String,
          !key.isEmpty else {
      fatalError("❌ Erro: Chave \(key.rawValue) não encontrada no Info.plist.")
    }
    return key
  }
}
