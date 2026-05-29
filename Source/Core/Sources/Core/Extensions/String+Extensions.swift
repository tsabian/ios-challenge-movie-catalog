//
//  String+Extensions.swift
//  Core
//
//  Created by Tiago de Oliveira on 29/05/26.
//

public extension String {
  func getYear() -> Int? {
    Int(split(separator: "-").first ?? "")
  }
}
