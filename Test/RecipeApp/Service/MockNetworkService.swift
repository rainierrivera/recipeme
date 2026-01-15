//
//  MockNetworkService.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

import Foundation

// MockNetworkService will be used to get the local response json
// This is where we handle the return of recipes
final class MockNetworkService: Network {
  
  private let jsonProvider: LocalJSONRecipeProvider = LocalJSONRecipeProvider()
  
  func request<T: Decodable>(_ provider: NetworkProvider,
                             responseType: T.Type) async throws -> T {
    
    let recipes = try jsonProvider.loadRecipes()
    let payload = RecipePayload(recipes: recipes)
    
    switch provider {
    case RecipeAPI.fetchRecipes:
      let data = try JSONEncoder().encode(payload)
      return try JSONDecoder().decode(T.self, from: data)
      
    case let RecipeAPI.search(categories, ingredients, servings, query):
      let selectedCategories = categories
        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
        .filter { !$0.isEmpty }

      let selectedIngredients = ingredients
        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
        .filter { !$0.isEmpty }

      let selectedServings = servings

      let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

      let filtered: [Recipe] = payload.recipes.filter { recipe in
        // Categories: across selected category
        if !selectedCategories.isEmpty {
          let categoryName = recipe.category.description.lowercased()
          if !selectedCategories.contains(where: { categoryName == $0 }) {
            return false
          }
        }

        // Ingredients: AND across selected ingredients
        if !selectedIngredients.isEmpty {
          var isIncluded = false
          let recipeIngredientNames = Set(recipe.ingredients.map { $0.name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() })
          for ing in selectedIngredients {
            if recipeIngredientNames.contains(ing) {
              isIncluded = true
            }
          }
          if !isIncluded { return false }
        }

        // Servings: OR across selected servings
        if !selectedServings.isEmpty {
          if !selectedServings.contains(recipe.numberOfServings) {
            return false
          }
        }

        // Query: match title/subtitle
        // content and title should be searchable
        // subtitle = content
        if !q.isEmpty {
          let fullText = "\(recipe.title) \(recipe.subtitle)".lowercased()
          if !fullText.contains(q) {
            return false
          }
        }

        return true
      }

      let filteredPayload = RecipePayload(recipes: filtered)
      let data = try JSONEncoder().encode(filteredPayload)
      
      return try JSONDecoder().decode(T.self, from: data)
      
    default: throw NetworkServiceError.emptyResponse // just throw any error for now..
    }
  }
}
