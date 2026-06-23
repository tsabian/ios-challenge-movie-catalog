//
//  MovieDataStorage.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

import SwiftData

@MainActor
class MovieDataStorage {
  let context: ModelContext

  init(context: ModelContext) {
    self.context = context
  }

  final func save() throws {
    guard context.hasChanges else { return }
    try context.save()
  }
}
