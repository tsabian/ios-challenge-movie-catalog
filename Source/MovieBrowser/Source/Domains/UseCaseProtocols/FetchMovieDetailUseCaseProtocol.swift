//
//  FetchMovieDetailUseCaseProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

protocol FetchMovieDetailUseCaseProtocol {
  func execute(movie id: Int) async throws -> MovieDetailsModel
}
