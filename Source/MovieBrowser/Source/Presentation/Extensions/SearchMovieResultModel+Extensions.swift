//
//  SearchMovieResultModel+Extensions.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/06/26.
//

import Core
import Foundation

extension SearchMovieResultModel {
  var rankAverageText: String {
    String(format: "%.2f", rankAverage)
  }

  var releaseYear: String {
    guard let currentDate = releaseDate.toDateTime(withFormat: "yyyy-MM-dd") else {
      return ""
    }
    return Calendar.current.component(.year, from: currentDate).description
  }
}
