//
//  ReviewAdapter.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import Foundation

struct ReviewAdapter {
  func adapt(dto: ReviewCatalogDto) -> ReviewModel {
    ReviewModel(id: dto.id,
                reviews: dto.results.compactMap(adaptUserReview),
                totalPages: dto.page,
                totalResults: dto.totalPages)
  }

  private func adaptUserReview(element: Review) -> UserReviewModel {
    UserReviewModel(id: element.id,
                    author: element.author,
                    content: element.content,
                    name: element.authorDetails.name,
                    username: element.authorDetails.username,
                    url: element.url,
                    avatarPath: element.authorDetails.avatarPath,
                    rating: String(format: "%.2f", element.authorDetails.rating),
                    createdAt: element.createdAt)
  }
}
