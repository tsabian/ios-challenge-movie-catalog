//
//  RecomendationsView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

import SwiftUI

struct RecomendationsView: View {
  @Environment(\.appContainer) private var appContainer

  private let movieCatalog: MovieCatalogModel?
  private let isLoading: Bool
  private let handleDetail: (MovieModel) -> Void

  init(movieCatalog: MovieCatalogModel?,
       isLoading: Bool,
       handleDetail: @escaping (MovieModel) -> Void) {
    self.movieCatalog = movieCatalog
    self.isLoading = isLoading
    self.handleDetail = handleDetail
  }

  var body: some View {
    if isLoading {
      LoadingView()
    } else if let catalog = movieCatalog, catalog.totalResults > 0 {
      content(catalog: catalog)
    } else {
      AlternativeFlowStateView(title: String(localized: .noResultsTitle),
                               message: String(localized: .noResultsMessage))
    }
  }

  private func content(catalog: MovieCatalogModel) -> some View {
    VStack {
      ForEach(catalog.movies, id: \.id) { movie in
        VStack {
          RemotePosterView(viewModel: appContainer.viewModelFactory.makeRemotePoster(),
                           pathURLString: movie.backdropPath)
            .frame(maxWidth: .infinity)
            .cornerRadius(8)

          Text(movie.title)
            .font(MovieBrowserFontsStyle.body)
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .clipShape(Rectangle())
        .aspectRatio(contentMode: .fill)
        .onTapGesture {
          handleDetail(movie)
        }
      }
    }
  }
}

#Preview {
  RecomendationsView(movieCatalog: .mock(),
                     isLoading: false,
                     handleDetail: { movie in
                       debugPrint(movie)
                     })
}
