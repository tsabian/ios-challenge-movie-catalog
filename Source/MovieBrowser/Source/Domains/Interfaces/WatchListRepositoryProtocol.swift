//
//  WatchListRepositoryProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

protocol WatchListRepositoryProtocol {
  func fetchWatchList() throws -> [MovieDetailsModel]
  func fetch(by id: Int) throws -> MovieDetailsModel?
  func addBookmark(movie: MovieDetailsModel) throws
  func deleteBookmark(movie: MovieDetailsModel) throws
  func markAsWatched(movie: MovieDetailsModel) throws
  func markAsUnwatched(movie: MovieDetailsModel) throws
}
