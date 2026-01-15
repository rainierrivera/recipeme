//
//  SearchViewModel.swift
//  Test
//
//  Created by Rainier Rivera on 1/14/26.
//

import SwiftUI

@MainActor
final class SearchViewModel: ObservableObject {
  
  // MARK: Properties
  @Published var query: String = "" {
    didSet {
      refreshFilteredResults()
    }
  }

  @Published private(set) var isLoading: Bool = false
  @Published private(set) var errorMessage: String?

  @Published private(set) var filteredGroupedRecipes: [Category: [Recipe]] = [:]
  @Published private(set) var filteredSortedCategories: [Category] = []

  @Published var isSearchFieldSheetPresented: Bool = false
  @Published var currentField: SearchField = .category
  @Published private(set) var selectedItemsByField: [SearchField: [String]] = [:]
  
  private let network: RecipeNetworkType
  private var recipes: [Recipe] = []
  private var searchRequestID: Int = 0
  private let onSelectRecipe: (Recipe) -> Void
  let selectedCategory: Category?

  // MARK: Initialization
  init(network: RecipeNetworkType = RecipeNetworkService(),
       selectedCategory: Category? = nil,
       onSelectRecipe: @escaping (Recipe) -> Void) {
    self.network = network
    self.onSelectRecipe = onSelectRecipe
    self.selectedCategory = selectedCategory
  }
  
  // MARK: Private methods

  private func loadRecipesWithDelayIfNeeded() async {
    if !recipes.isEmpty {
      refreshFilteredResults()
      return
    }

    guard !isLoading else { return }
    isLoading = true
    errorMessage = nil

    // Simulate network latency
    try? await Task.sleep(nanoseconds: 2_000_000_000)

    do {
      recipes = try await network.fetchAllRecipes()
      isLoading = false
      
      if let selectedCategory = selectedCategory {
        setSelectedSearch([selectedCategory.description], for: .category)
      } else {
        refreshFilteredResults()
      }
    } catch {
      recipes = []
      isLoading = false
      errorMessage = "Failed to load recipes: \(error.localizedDescription)"
      filteredGroupedRecipes = [:]
      filteredSortedCategories = []
    }
  }

  private func refreshFilteredResults() {
    Task {
      await performSearch()
    }
  }

  private func performSearch() async {
    // Ensure we have the full dataset loaded at least once for sheets.
    if recipes.isEmpty {
      await loadRecipesWithDelayIfNeeded()
    }

    guard !isLoading else { return }

    isLoading = true
    errorMessage = nil

    // These are the values the endpoint should use.
    let categories = selectedItems(for: .category)
    let ingredients = selectedItems(for: .ingredients)

    do {
      let results = try await network.searchRecipes(
        categories: categories,
        ingredients: ingredients,
        servings: selectedItems(for: .servings).compactMap(Int.init),
        queryText: query
      )

      filteredGroupedRecipes = Dictionary(grouping: results, by: { $0.category })
      

      filteredSortedCategories = Category.allCases
        .filter { filteredGroupedRecipes[$0] != nil }

      isLoading = false
    } catch {

      filteredGroupedRecipes = [:]
      filteredSortedCategories = []
      isLoading = false
      errorMessage = "Search failed: \(error.localizedDescription)"
    }
  }
  
  // MARK: Public methods
  func didTapPill(field: SearchField) {
    currentField = field
    loadRecipesIfNeeded()
    isSearchFieldSheetPresented = true
  }

  func loadRecipesIfNeeded() {
    Task {
      await loadRecipesWithDelayIfNeeded()
    }
  }
  
  func selectedRecipe(item: Recipe) {
    onSelectRecipe(item)
  }

  func cachedRecipes() -> [Recipe] {
    recipes
  }

  func selectedItems(for field: SearchField) -> [String] {
    selectedItemsByField[field] ?? []
  }

  func setSelectedSearch(_ selected: [String], for field: SearchField) {
    selectedItemsByField[field] = selected
    refreshFilteredResults()
  }

  func displayValue(for field: SearchField) -> String {
    let selected = selectedItems(for: field)

    if selected.isEmpty {
      switch field {
      case .servings:
        return "Any"
      default:
        return "All"
      }
    }

    if selected.count == 1 {
      return selected[0]
    }

    return "\(selected.count) selected"
  }
}
