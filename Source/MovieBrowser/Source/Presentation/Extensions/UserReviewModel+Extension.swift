//
//  UserReviewModel+Extension.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 08/06/26.
//

import Core
import Foundation

extension UserReviewModel {
  var ratingText: String {
    String(format: "%.2f", rating ?? 0)
  }

  var createdAtText: String? {
    createdAt?.toString(toFormat: "dd, MMMM, yyyy")
  }
}
