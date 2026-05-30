//
//  FetchMovieReviewsUseCaseProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

protocol FetchMovieReviewsUseCaseProtocol {
  func execute(movieID: Int, page: Int) async throws -> ReviewModel
}
