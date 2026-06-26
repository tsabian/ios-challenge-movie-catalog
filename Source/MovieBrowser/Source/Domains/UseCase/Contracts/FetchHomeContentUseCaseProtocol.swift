//
//  FetchHomeContentUseCaseProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

protocol FetchHomeContentUseCaseProtocol {
  func execute(category: MovieCategory) async throws -> HomeContentModel
}
