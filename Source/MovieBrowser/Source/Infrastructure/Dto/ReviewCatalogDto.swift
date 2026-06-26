//
//  ReviewCatalogDto.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

struct ReviewCatalogDto: Decodable {
  let id, page: Int
  let results: [ReviewDto]
  let totalPages, totalResults: Int

  enum CodingKeys: String, CodingKey {
    case id, page, results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}
