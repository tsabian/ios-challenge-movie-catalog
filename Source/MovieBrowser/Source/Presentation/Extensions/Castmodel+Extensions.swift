//
//  CastModel+Extensions.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 08/06/26.
//

import Foundation

extension CastModel {
  var popularityText: String {
    String(format: "%.1f", popularity)
  }
}
