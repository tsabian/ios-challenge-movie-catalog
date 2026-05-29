//
//  ErrorResponseDto.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 28/05/26.
//

struct ErrorResponseDto: Decodable, Error {
  let statusCode: Int
  let statusMessage: String
  let success: Bool

  enum CodingKeys: String, CodingKey {
    case statusCode = "status_code"
    case statusMessage = "status_message"
    case success
  }
}
