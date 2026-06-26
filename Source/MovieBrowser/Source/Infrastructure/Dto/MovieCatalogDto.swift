//
//  MovieCatalogDto.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

// MARK: - Movie

struct MovieCatalogDto: Decodable {
  let dates: DatesDto?
  let page: Int
  let results: [MovieDto]
  let totalPages, totalResults: Int

  enum CodingKeys: String, CodingKey {
    case dates, page, results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}
