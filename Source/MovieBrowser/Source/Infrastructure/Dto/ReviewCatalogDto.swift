//
//  ReviewCatalogDto.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

// MARK: - ReviewCatalogDto

struct ReviewCatalogDto: Decodable {
  let id, page: Int
  let results: [Review]
  let totalPages, totalResults: Int

  enum CodingKeys: String, CodingKey {
    case id, page, results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

// MARK: - Result

struct Review: Decodable {
  let author: String
  let authorDetails: AuthorDetailsDto
  let content: String
  let createdAt: String
  let id: String
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
