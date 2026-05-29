//
//  MovieDetailView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 28/05/26.
//

import SwiftUI

struct MovieDetailView: View {
  let movie: HomeMovieModel

  var body: some View {
    NavigationStack {
      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          Text(movie.posterPath)
            .frame(maxWidth: .infinity, alignment: .leading)
          Spacer()
        }
        .padding([.leading, .trailing], 22)
      }
      .navigationTitle(movie.title)
    }
    .scrollContentBackground(.hidden)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

#Preview {
  MovieDetailView(movie: .init(id: 1, title: "Miranha",
                               posterPath: "/asdasdas.png", rank: 1))
}
