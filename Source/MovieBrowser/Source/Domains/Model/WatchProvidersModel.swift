//
//  WatchProvidersModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

import SwiftUI

struct WatchProvidersModel: Identifiable {
  let id: Int
  let results: [String: WatchProviderResultModel]
}
