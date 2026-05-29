//
//  MovieDetailContentView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 29/05/26.
//

import SwiftUI

struct MovieDetailContentView: View {
  @Environment(\.appContainer) private var appContainer
  @Environment(\.dynamicTypeSize) private var dynamicTypeSize
  @ScaledMetric(relativeTo: .body) private var posterWidth: CGFloat = 95
  @ScaledMetric(relativeTo: .body) private var posterHeight: CGFloat = 120
  @ScaledMetric(relativeTo: .body) private var backdropHeight: CGFloat = 210
  @State private var currentInfo: DetailInfo = .about

  private var isAccessibilitySize: Bool {
    dynamicTypeSize.isAccessibilitySize
  }

  var movieDetail: MovieDetailsModel
  var infoTapAction: (DetailInfo) -> Void

  init(movieDetail: MovieDetailsModel,
       infoTapAction: @escaping (DetailInfo) -> Void) {
    self.movieDetail = movieDetail
    self.infoTapAction = infoTapAction
  }

  var body: some View {
    ZStack(alignment: .top) {
      RemotePosterView(viewModel: appContainer.viewModelFactory.makeRemotePoster(),
                       pathURLString: movieDetail.backdropPath,
                       size: .medium)
        .scaledToFill()
        .frame(height: min(backdropHeight, 260))
        .frame(maxWidth: .infinity)
        .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 0,
                                                             bottomLeading: 16,
                                                             bottomTrailing: 16,
                                                             topTrailing: 0)))

      VStack {
        headerContent
        metadata
        info
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  private var headerContent: some View {
    VStack(spacing: 16) {
      HStack(alignment: .top, spacing: 12) {
        RemotePosterView(viewModel: appContainer.viewModelFactory.makeRemotePoster(),
                         pathURLString: movieDetail.posterPath,
                         size: .small)
          .frame(width: min(posterWidth, 130), height: min(posterHeight, 165))
          .cornerRadius(16)

        VStack(alignment: .leading) {
          Spacer()
          Text(movieDetail.title)
            .font(MovieBrowserFontsStyle.title.bold())
            .lineLimit(isAccessibilitySize ? nil : 3)
            .frame(height: 70)
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
        }
        .frame(height: 120)

        Label(movieDetail.rankAverage, systemImage: "star")
          .font(MovieBrowserFontsStyle.footnote.bold())
          .foregroundStyle(Color.secondaryOrange)
          .padding(.horizontal, 10)
          .padding(.vertical, 6)
          .background(Color.accentColor)
          .clipShape(RoundedRectangle(cornerRadius: 8))
          .fixedSize()
      }
      .padding(.top, 160)
      .padding(.horizontal, 16)
    }
  }

  private var metadata: some View {
    ViewThatFits {
      HStack {
        Label("\(movieDetail.releaseYear)", systemImage: "calendar")
        Text("|")
        Label(movieDetail.runtime, systemImage: "clock")
        Text("|")
        Label(movieDetail.genre, systemImage: "ticket")
      }
      VStack {
        Label("\(movieDetail.releaseYear)", systemImage: "calendar")
        Text("|")
        Label(movieDetail.runtime, systemImage: "clock")
        Text("|")
        Label(movieDetail.genre, systemImage: "ticket")
      }
    }
    .foregroundStyle(Color.accentLightGray)
    .padding(.top, 16)
  }

  private var info: some View {
    VStack {
      HStack(alignment: .top, spacing: 12) {
        ForEach(DetailInfo.allCases, id: \.self) { element in
          VStack {
            Text(element.title)
              .font(MovieBrowserFontsStyle.body.bold())
              .lineLimit(1)
            Rectangle()
              .fill(Color.accentLightGray)
              .frame(maxWidth: .infinity)
              .frame(height: currentInfo == element ? 5.0 : 0)
              .opacity(currentInfo == element ? 1.0 : 0)
              .animation(.easeInOut(duration: 0.4), value: currentInfo)
          }
          .contentShape(Rectangle())
          .onTapGesture {
            guard currentInfo != element else { return }
            currentInfo = element
            infoTapAction(element)
          }
        }
      }
      ScrollView(.vertical, showsIndicators: false) {
        switch currentInfo {
        case .about: aboutMovie
        case .reviews: reviews
        case .cast: cast
        }
      }
      .padding(.top, 24)
    }
    .frame(maxWidth: .infinity)
    .padding(.top, 16)
    .padding(.horizontal, 16)
  }

  private var aboutMovie: some View {
    Text(movieDetail.overview)
  }

  private var reviews: some View {
    Text("No reviews yet")
  }

  private var cast: some View {
    Text("No cast yet")
  }
}

#Preview {
  MovieDetailContentView(movieDetail: .mock(),
                         infoTapAction: { info in
                           debugPrint("review tap \(info)")
                         })
}
