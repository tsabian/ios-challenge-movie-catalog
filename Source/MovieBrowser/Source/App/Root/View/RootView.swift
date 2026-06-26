//
//  RootView.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 24/05/26.
//

import SwiftData
import SwiftUI

struct RootView<ViewModel: RootViewModelProtocol>: View {
  @StateObject private var viewModel: ViewModel

  init(viewModel: @autoclosure @escaping () -> ViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel())
  }

  var body: some View {
    ZStack {
      content
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .ignoresSafeArea()
    .animation(.easeInOut(duration: 0.5), value: viewModel.state)
    .task {
      await viewModel.startApp()
    }
  }

  @ViewBuilder
  private var content: some View {
    switch viewModel.state {
    case .idle, .loading:
      SplashScreenView()
    case .error:
      AlternativeFlowStateView(title: String(localized: .somethingWentWrong),
                               message: String(localized: .tryAgainFewMinutes),
                               imageName: .error)
    case .loaded:
      ContentView()
    }
  }
}

#Preview {
  RootView(viewModel: RootPreviewMockFactory
    .make()
    .updateState(with: .loaded)
  )
}
