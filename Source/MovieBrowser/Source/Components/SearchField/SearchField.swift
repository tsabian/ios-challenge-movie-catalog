//
//  SearchField.swift
//  MovieBrowser
//
//  Created by Tiago de Oliveira on 25/05/26.
//

import SwiftUI

struct SearchField: View {
  private let placeholder: LocalizedStringKey
  private let debounceDuration: Duration

  @State private var searchText = ""
  @State private var debounceTask: Task<Void, Never>?
  @FocusState private var isSearchFocused: Bool
  @Environment(\.onTextChangeAction) private var onTextChange
  @Environment(\.onTextClearAction) private var onTextClear
  @Environment(\.onSearchAction) private var onMovieSearch

  init(_ placeholder: LocalizedStringKey = "\(.search)",
       debounceDuration: Duration = .milliseconds(350)
  ) {
    self.placeholder = placeholder
    self.debounceDuration = debounceDuration
  }

  var body: some View {
    HStack(spacing: 8) {
      TextField(placeholder, text: $searchText)
        .font(MovieBrowserFontsStyle.body)
        .foregroundStyle(Color.white)
        .tint(Color.white)
        .focused($isSearchFocused)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
        .submitLabel(.search)
        .onSubmit {
          handleSubmit()
        }
      if !searchText.isEmpty {
        Button {
          clearSearch()
        } label: {
          Image(systemName: "xmark.circle.fill")
            .foregroundStyle(Color.accentLightGray)
        }
        .buttonStyle(.plain)
      }
      Button {
        handleSubmit()
      } label: {
        Image(systemName: "magnifyingglass")
          .foregroundStyle(Color.accentLightGray)
      }
      .buttonStyle(.plain)
    }
    .padding(.horizontal, 15)
    .frame(height: 40)
    .background {
      RoundedRectangle(cornerRadius: 12, style: .continuous)
        .fill(Color.accentGray)
    }
    .overlay {
      RoundedRectangle(cornerRadius: 12, style: .continuous)
        .strokeBorder(Color.accentLightGray, lineWidth: 2)
    }
    .onChange(of: searchText) { _, newValue in
      handleTextChange(newValue)
    }
    .onDisappear {
      debounceTask?.cancel()
    }
  }

  private func handleTextChange(_ text: String) {
    debounceTask?.cancel()
    let query = sanitized(text)
    guard !query.isEmpty else {
      onTextChange?("")
      return
    }
    debounceTask = Task {
      do {
        try await Task.sleep(for: debounceDuration)
        guard !Task.isCancelled else { return }
        await MainActor.run {
          onTextChange?(query)
        }
      } catch {
        // Task cancelada pelo debounce.
      }
    }
  }

  private func handleSubmit() {
    debounceTask?.cancel()
    let query = sanitized(searchText)
    guard !query.isEmpty else {
      clearSearch()
      return
    }
    onMovieSearch?(query)
    isSearchFocused = false
  }

  private func clearSearch() {
    debounceTask?.cancel()
    searchText = ""
    onTextClear?()
    onTextChange?("")
    isSearchFocused = false
  }

  private func sanitized(_ text: String) -> String {
    text.trimmingCharacters(in: .whitespacesAndNewlines)
  }
}

extension View {
  func onMovieSearch(perform action: @escaping (String) -> Void) -> some View {
    environment(\.onSearchAction, action)
  }

  func onTextChange(perform action: @escaping (String) -> Void) -> some View {
    environment(\.onTextChangeAction, action)
  }

  func onTextClear(perform action: @escaping () -> Void) -> some View {
    environment(\.onTextClearAction, action)
  }
}

#Preview {
  SearchField()
}
