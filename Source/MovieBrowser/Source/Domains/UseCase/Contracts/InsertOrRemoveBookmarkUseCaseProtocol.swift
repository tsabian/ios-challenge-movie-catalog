//
//  InsertOrRemoveBookmarkUseCaseProtocol.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

protocol InsertOrRemoveBookmarkUseCaseProtocol {
  func execute(detail: MovieDetailsModel) throws -> Bool
}
