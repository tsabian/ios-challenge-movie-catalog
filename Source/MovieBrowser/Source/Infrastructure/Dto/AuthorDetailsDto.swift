//
//  AuthorDetailsDto.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

struct AuthorDetailsDto: Decodable {
  let name, username: String
  let avatarPath: String?
  let rating: Double

  enum CodingKeys: String, CodingKey {
    case name, username
    case avatarPath = "avatar_path"
    case rating
  }
}
