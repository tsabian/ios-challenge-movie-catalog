//
//  MovieAdapter.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

struct MovieAdapter {
  func adapt(dto movies: [MovieDto],
             for category: MovieCategory) -> [HomeMovieModel] {
    movies.enumerated()
      .compactMap { index, element in
        HomeMovieModel(id: element.id,
                       title: element.title,
                       posterPath: buildPosterPath(from: element.posterPath),
                       rank: index + 1,
                       category: category)
      }
  }

  private func buildPosterPath(from path: String) -> String {
    "\(AppEnvironment.current.value(for: .tmdbImageBaseUrl))/\(TMDBImageSize.small.rawValue)/\(path)"
  }
}
