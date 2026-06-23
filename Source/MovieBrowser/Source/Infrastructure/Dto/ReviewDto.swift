//
//  ReviewDto.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

import Foundation

struct ReviewDto: Decodable {
  let id: String
  let author: String
  let authorDetails: AuthorDetailsDto
  let content: String
  let createdAt: Date
  let updatedAt: String
  let url: String

  enum CodingKeys: String, CodingKey {
    case author
    case authorDetails = "author_details"
    case content
    case createdAt = "created_at"
    case id
    case updatedAt = "updated_at"
    case url
  }
}
