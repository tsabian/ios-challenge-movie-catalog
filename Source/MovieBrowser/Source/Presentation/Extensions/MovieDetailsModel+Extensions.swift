//
//  MovieDetailsModel+Extensions.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 08/06/26.
//

import Foundation

extension MovieDetailsModel {
  var releaseYear: String {
    String(releaseDate.split(separator: "-").first ?? "")
  }

  var runtimeText: String {
    String(localized: .runtimeMinutes(runtime))
  }

  var rankAverageText: String {
    String(format: "%.2f", rankAverage)
  }
}
