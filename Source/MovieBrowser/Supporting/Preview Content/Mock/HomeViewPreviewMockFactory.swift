//
//  HomeViewPreviewMockFactory.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 27/05/26.
//

import SwiftUI

enum HomeViewPreviewMockFactory {
  @MainActor
  static func makeViewModelMock() -> some HomeViewModelProtocol {
    let useCaseSpy = FetchHomeMovieUseCaseMock()
    let catalog = PreviewFactory.shared.makeMovieCatalog(for: .topRated)
    let movies = MovieAdapter().adapt(dto: catalog.results, for: .nowPlaying)
    useCaseSpy.result = HomeContent(rankedMovies: movies,
                                    movies: movies)
    return HomeViewModel(useCase: useCaseSpy)
  }
}
