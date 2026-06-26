//
//  Department.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

enum Department: String, Decodable {
  case acting = "Acting"
  case art = "Art"
  case camera = "Camera"
  case costumeMakeUp = "Costume & Make-Up"
  case crew = "Crew"
  case directing = "Directing"
  case editing = "Editing"
  case lighting = "Lighting"
  case production = "Production"
  case sound = "Sound"
  case visualEffects = "Visual Effects"
  case writing = "Writing"
  case unknown

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    guard !container.decodeNil() else {
      self = .unknown
      return
    }
    let value = try container.decode(String.self)
    self = Department(rawValue: value) ?? .unknown
  }
}
