//
//  URL+Stub.swift
//  Core
//
//  Created by Tiago de Oliveira on 22/05/26.
//

import Foundation

extension URL {
  static func stub(urlString: String = "https://example.com/fetch") -> URL {
    URL(string: urlString) ?? URL(fileURLWithPath: "/")
  }
}
