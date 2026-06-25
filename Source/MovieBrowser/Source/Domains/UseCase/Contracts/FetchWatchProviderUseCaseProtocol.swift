//
//  FetchWatchProviderUseCaseProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

protocol FetchWatchProviderUseCaseProtocol {
  func execute(movie: MovieDetailsModel) async throws -> WatchProviderResultModel?
}
