//
//  PreviewFactory.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 26/05/26.
//

import Core
import Foundation

extension MovieCategory {
  var fileMock: String {
    "\(rawValue.lowercased()).json"
  }
}

struct PreviewFactory {
  private let bundle: Bundle

  static let shared = PreviewFactory()

  private init(bundle: Bundle = .main) {
    self.bundle = bundle
  }

  func makeMovieCatalog(for category: MovieCategory) -> MovieCatalogDto {
    do {
      let dto: MovieCatalogDto = try bundle.decode(category.fileMock)
      return dto
    } catch let error as DecodingError {
      if case let .decodingFailed(description: description) = error {
        print(description)
      }
      fatalError("👎 Failed to decode \(category.fileMock)")
    } catch {
      fatalError("👎 Failed to decode \(category.fileMock)")
    }
  }
}
