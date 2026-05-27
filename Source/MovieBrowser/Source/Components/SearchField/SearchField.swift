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
  private let onSearch: (String) -> Void
  private let onTextChange: (String) -> Void
  private let onClear: () -> Void

  @State private var searchText = ""
  @State private var debounceTask: Task<Void, Never>?
  @FocusState private var isSearchFocused: Bool

  init(_ placeholder: LocalizedStringKey = "\(.search)",
       debounceDuration: Duration = .milliseconds(350),
       onSearch: @escaping (String) -> Void = { _ in },
       onTextChange: @escaping (String) -> Void = { _ in },
       onClear: @escaping () -> Void = {}
  ) {
    self.placeholder = placeholder
    self.debounceDuration = debounceDuration
    self.onSearch = onSearch
    self.onTextChange = onTextChange
    self.onClear = onClear
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
      onTextChange("")
      return
    }
    debounceTask = Task {
      do {
        try await Task.sleep(for: debounceDuration)
        guard !Task.isCancelled else { return }
        await MainActor.run {
          onTextChange(query)
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
    onSearch(query)
    isSearchFocused = false
  }

  private func clearSearch() {
    debounceTask?.cancel()
    searchText = ""
    onClear()
    onTextChange("")
    isSearchFocused = false
  }

  private func sanitized(_ text: String) -> String {
    text.trimmingCharacters(in: .whitespacesAndNewlines)
  }
}

#Preview {
  SearchField()
}
