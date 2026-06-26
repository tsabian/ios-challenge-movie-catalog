//
//  InsertOrRemoveBookmarkUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

final class InsertOrRemoveBookmarkUseCase: InsertOrRemoveBookmarkUseCaseProtocol {
  private let watchListRepository: WatchListRepositoryProtocol

  init(watchListRepository: WatchListRepositoryProtocol) {
    self.watchListRepository = watchListRepository
  }

  func execute(detail: MovieDetailsModel) throws -> Bool {
    var isBookmark = false
    if try watchListRepository.fetch(by: detail.id) != nil {
      try watchListRepository.deleteBookmark(movie: detail)
    } else {
      try watchListRepository.addBookmark(movie: detail)
      isBookmark = true
    }
    return isBookmark
  }
}
