//
//  ReviewsModel.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

struct ReviewModel: Identifiable, Hashable {
  let id: Int
  let reviews: [UserReviewModel]
  let totalPages, totalResults: Int
}

struct UserReviewModel: Identifiable, Hashable {
  let id: String
  let author: String
  let content: String
  let name, username: String
  let url: String?
  let avatarPath: String?
  let rating: String
  let createdAt: String
}
