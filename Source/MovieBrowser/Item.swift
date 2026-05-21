//
//  Item.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 20/05/26.
//

import Foundation
import SwiftData

@Model
final class Item {
  var timestamp: Date

  init(timestamp: Date) {
    self.timestamp = timestamp
  }
}
