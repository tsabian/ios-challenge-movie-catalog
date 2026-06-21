//
//  MovieListView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 21/06/26.
//

import SwiftUI

struct MovieListView: View {
  @Environment(\.appContainer) private var appContainer: AppContainer

  private let movieCatalog: SearchMovieCatalogModel
  private let isLoadingNextPage: Bool
  private let getGenreName: (Int) -> String
  private let makeMovieModel: (SearchMovieResultModel) -> MovieModel
  private let loadNextPage: () async -> Void
  private let handleNavigate: (MovieModel) -> Void

  init(
    movieCatalog: SearchMovieCatalogModel,
    isLoadingNextPage: Bool,
    getGenreName: @escaping (Int) -> String,
    makeMovieModel: @escaping (SearchMovieResultModel) -> MovieModel,
    loadNextPage: @escaping () async -> Void,
    handleNavigate: @escaping (MovieModel) -> Void
  ) {
    self.movieCatalog = movieCatalog
    self.isLoadingNextPage = isLoadingNextPage
    self.getGenreName = getGenreName
    self.makeMovieModel = makeMovieModel
    self.loadNextPage = loadNextPage
    self.handleNavigate = handleNavigate
  }

  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(spacing: 24) {
        ForEach(movieCatalog.movies, id: \.id) { movie in
          movieRow(movie)
            .onAppear {
              loadNextPageIfNeeded(currentMovie: movie)
            }
        }
        if isLoadingNextPage {
          LoadingView()
        }
      }
    }
  }

  private func movieRow(_ movie: SearchMovieResultModel) -> some View {
    HStack {
      RemotePosterView(viewModel: appContainer.viewModelFactory.makeRemotePoster(),
                       pathURLString: movie.posterPath)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .frame(width: 95, height: 120)
      VStack(alignment: .leading, spacing: 8) {
        Text(movie.title)
          .lineLimit(1)
          .font(MovieBrowserFontsStyle.body.bold())
        Spacer()
        Label(movie.rankAverageText, systemImage: "star")
          .foregroundStyle(Color.secondaryOrange)
          .font(MovieBrowserFontsStyle.body)
        if let genre = movie.genre {
          Label(getGenreName(genre), systemImage: "ticket")
            .font(MovieBrowserFontsStyle.body)
        }
        Label(movie.releaseYear, systemImage: "calendar")
          .font(MovieBrowserFontsStyle.body)
        if movie.runtime > 0 {
          Label("\(movie.runtime)", systemImage: "clock")
            .font(MovieBrowserFontsStyle.body)
        }
      }
      .padding(.leading, 8)
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .contentShape(Rectangle())
    .onTapGesture {
      handleNavigate(makeMovieModel(movie))
    }
  }

  private func loadNextPageIfNeeded(currentMovie: SearchMovieResultModel) {
    guard currentMovie.id == movieCatalog.movies.last?.id,
          movieCatalog.page < movieCatalog.totalPages,
          !isLoadingNextPage else {
      return
    }
    Task {
      await loadNextPage()
    }
  }
}

#Preview {
  MovieListView(
    movieCatalog: .mock(),
    isLoadingNextPage: true) { _ in
      "Unknown"
    } makeMovieModel: { _ in
      .mock()
    } loadNextPage: {
      debugPrint("Load Next Page")
    } handleNavigate: { movie in
      debugPrint("navigate to \(movie.title)")
    }
}
