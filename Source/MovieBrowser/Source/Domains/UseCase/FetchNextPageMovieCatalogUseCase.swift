//
//  FetchNextPageMovieCatalogUseCase.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 19/06/26.
//

final class FetchNextPageMovieCatalogUseCase: FetchNextPageMovieCatalogUseCaseProtocol {
  private let repository: MovieCatalogRepositoryProtocol

  init(repository: MovieCatalogRepositoryProtocol) {
    self.repository = repository
  }

  func execute(by category: MovieCategory,
               content: inout HomeContentModel) async throws {
    guard let catalog = content.movieCatalog[category] else {
      try await fetchFirstPage(category, &content)
      return
    }

    guard catalog.page < catalog.totalPages else {
      throw UseCaseError.noMorePages
    }

    try await fetchNextPage(category, catalog, &content)
  }

  private func fetchFirstPage(_ category: MovieCategory,
                              _ content: inout HomeContentModel) async throws {
    let model = try await fetchPage(category, 1)
    let updatedCatalog = updatedCatalog(content, category, model)
    let updatedContent = updatedContent(category, updatedCatalog, content)
    content = updatedContent
  }

  private func fetchNextPage(_ category: MovieCategory,
                             _ catalog: MovieCatalogModel,
                             _ content: inout HomeContentModel) async throws {
    let nextPage = catalog.page + 1
    let model = try await fetchPage(category, nextPage)
    let updatedCatalog = updatedCatalog(content, category, model)
    let updatedContent = updatedContent(category, updatedCatalog, content)
    content = updatedContent
  }

  private func fetchPage(_ category: MovieCategory,
                         _ page: Int) async throws -> MovieCatalogModel {
    try await repository.fetchMovies(category: category, page: page)
  }

  private func updatedCatalog(_ content: HomeContentModel,
                              _ category: MovieCategory,
                              _ nextCatalog: MovieCatalogModel) -> MovieCatalogModel {
    var movies = content.movieCatalog[category]?.movies ?? []
    movies.append(contentsOf: nextCatalog.movies)
    return MovieCatalogModel(page: nextCatalog.page,
                             movies: movies,
                             totalPages: nextCatalog.totalPages,
                             totalResults: nextCatalog.totalResults)
  }

  private func updatedContent(_ category: MovieCategory,
                              _ updatedCatalog: MovieCatalogModel,
                              _ content: HomeContentModel) -> HomeContentModel {
    var currentCatalog = content.movieCatalog
    currentCatalog[category] = updatedCatalog
    return HomeContentModel(rankedMovies: content.rankedMovies,
                            movieCatalog: currentCatalog)
  }
}
