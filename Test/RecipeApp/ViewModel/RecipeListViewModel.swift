//
//  RecipeListViewModel.swift
//  Test
//
//  Created by Rainier Rivera on 1/14/26.
//

import SwiftUI

@MainActor
final class RecipeListViewModel: ObservableObject {

  // MARK: Private observe/binding properties
  @Published var query: String = ""
  @Published private(set) var groupedRecipes: [Category: [Recipe]] = [:]
  @Published private(set) var sortedCategories: [Category] = []
  @Published private(set) var isLoading: Bool = true
  @Published private(set) var errorMessage: String?

  // MARK: Private properties
  private let network: RecipeNetworkType

  private let onSelectRecipe: (Recipe) -> Void
  private let onSelectSearch: () -> Void
  private let onSelectCategory: (Category) -> Void
  private var recipes: [Recipe] = []
  
  // MARK: Initialization
  init(
    network: RecipeNetworkType = RecipeNetworkService(),
    onSelectRecipe: @escaping (Recipe) -> Void,
    onSelectCategory: @escaping (Category) -> Void,
    onSelectSearch: @escaping () -> Void
  ) {
    self.network = network
    self.onSelectRecipe = onSelectRecipe
    self.onSelectSearch = onSelectSearch
    self.onSelectCategory = onSelectCategory
  }

  
  // MARK: Public methods
  
  func loadRecipes() async {
    isLoading = true
    errorMessage = nil

    // Simulate network latency
    try? await Task.sleep(nanoseconds: 2_000_000_000)

    do {
      recipes = try await network.fetchAllRecipes()
      groupedRecipes = Dictionary(grouping: recipes, by: { $0.category })

      // make sure to load only the Category that has recipe
      sortedCategories = Category.allCases
        .filter { groupedRecipes[$0] != nil }

      isLoading = false
    } catch {
      groupedRecipes = [:]
      sortedCategories = []
      isLoading = false
      errorMessage = "Failed to load recipes: \(error.localizedDescription)"
      print(error)
    }
  }
  
  func cachedRecipes() -> [Recipe] {
    recipes
  }

  func tappedRecipe(_ recipe: Recipe) {
    onSelectRecipe(recipe)
  }
  
  func tappedCategory(_ Category: Category) {
    onSelectCategory(Category)
  }

  func tappedSearch() {
    onSelectSearch()
  }
}
