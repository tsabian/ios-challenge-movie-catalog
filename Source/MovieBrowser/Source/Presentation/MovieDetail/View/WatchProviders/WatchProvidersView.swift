//
//  WatchProvidersView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 23/06/26.
//

import SwiftUI

struct WatchProvidersView: View {
  @Environment(\.appContainer) private var appContainer

  private let isLoading: Bool
  private let providers: WatchProviderResultModel?

  init(isLoading: Bool,
       providers: WatchProviderResultModel?) {
    self.isLoading = isLoading
    self.providers = providers
  }

  var body: some View {
    VStack {
      if isLoading {
        LoadingView()
      } else if providers?.buy == nil,
                providers?.flatrate == nil,
                providers?.free == nil,
                providers?.rent == nil,
                providers?.ads == nil {
        AlternativeFlowStateView(title: String(localized: .noProvidersTitle),
                                 message: String(localized: .noProvidersMessage))
      } else {
        ScrollView(.vertical, showsIndicators: false) {
          VStack {
            if let provider = providers?.flatrate {
              content(title: String(localized: .providerStream),
                      collection: provider)
            }
            if let provider = providers?.rent {
              content(title: String(localized: .providerRent),
                      collection: provider)
            }
            if let provider = providers?.buy {
              content(title: String(localized: .providerBuy),
                      collection: provider)
            }
            if let provider = providers?.free {
              content(title: String(localized: .providerFree),
                      collection: provider)
            }
          }
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  private func content(title: String,
                       collection: [WatchProviderModel]) -> some View {
    VStack {
      Text(title)
        .font(MovieBrowserFontsStyle.subTitle)
        .lineLimit(1)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 10)

      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(collection, id: \.id) { provider in
            VStack {
              RemotePosterView(
                viewModel: appContainer.viewModelFactory.makeRemotePoster(),
                pathURLString: provider.logoPath
              )
              .frame(width: 50, height: 50)
            }
          }
        }
      }
    }
    .padding(.vertical, 10)
  }
}

#Preview {
  WatchProvidersView(isLoading: false,
                     providers: .mock())
}
