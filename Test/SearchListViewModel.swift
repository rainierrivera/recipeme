//
//  SearchListViewModel.swift
//  Test
//
//  Created by Rainier Rivera on 1/14/26.
//

import SwiftUI

@MainActor
final class SearchListViewModel: ObservableObject {
  @Published var searchText: String = ""
  @Published private(set) var items: [String] = []
  @Published private(set) var selected: Set<String>
  @Published private(set) var isLoading: Bool = false
  @Published private(set) var errorMessage: String?

  private let recipes: [Recipe]
  private let onDone: ([String]) -> Void
  private let onCancel: () -> Void
  let field: SearchField

  init(
    recipes: [Recipe],
    field: SearchField,
    initiallySelected: [String],
    onDone: @escaping ([String]) -> Void,
    onCancel: @escaping () -> Void
  ) {
    self.recipes = recipes
    self.selected = Set(initiallySelected)
    self.onDone = onDone
    self.onCancel = onCancel
    self.field = field
  }

  var filteredItems: [String] {
    let base = items

    guard !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
      return base
    }

    let q = searchText.lowercased()
    return base.filter { $0.lowercased().contains(q) }
  }

  func load() {
    guard !isLoading else { return }
    isLoading = true
    errorMessage = nil

    switch field {
    case .category:
      let all = Category.allDescriptions
      let normalized = all
        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        .filter { !$0.isEmpty }

      items = Array(Set(normalized)).sorted { $0.localizedCaseInsensitiveCompare($1) == .orderedAscending }

    case .ingredients:
      let all: [String] = recipes.flatMap { recipe in
        recipe.ingredients.compactMap { $0.name }
      }

      let normalized = all
        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        .filter { !$0.isEmpty }

      items = Array(Set(normalized)).sorted { $0.localizedCaseInsensitiveCompare($1) == .orderedAscending }

    case .servings:
      items = ["1" ,"2", "3", "4"]
    }

    isLoading = false
  }

  func isSelected(_ item: String) -> Bool {
    selected.contains(item)
  }

  func toggle(_ item: String) {
    if selected.contains(item) {
      selected.remove(item)
    } else {
      selected.insert(item)
    }
  }

  func done() {
    // Empty selection means “All” in the parent.
    guard !selected.isEmpty else {
      onDone([])
      return
    }

    let sorted = selected.sorted { $0.localizedCaseInsensitiveCompare($1) == .orderedAscending }
    onDone(sorted)
  }

  func cancel() {
    onCancel()
  }
}
