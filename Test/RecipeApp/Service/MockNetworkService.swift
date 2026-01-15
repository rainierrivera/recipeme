//
//  MockNetworkService.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

import Foundation

final class MockNetworkService: Network {
  
  private let jsonProvider: LocalJSONRecipeProvider = LocalJSONRecipeProvider()
  
  func request<T: Decodable>(_ provider: NetworkProvider, responseType: T.Type) async throws -> T {
    let recipes = try jsonProvider.loadRecipes()
    let payload = RecipePayload(recipes: recipes)
    
    switch provider {
    case RecipeAPI.fetchRecipes:
      let data = try JSONEncoder().encode(payload)
      return try JSONDecoder().decode(T.self, from: data)
      
    case let RecipeAPI.search(course, ingredients, servings, query):
      let selectedCourses = course
        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
        .filter { !$0.isEmpty }

      let selectedIngredients = ingredients
        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
        .filter { !$0.isEmpty }

      let selectedServings = servings

      let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

      let filtered: [Recipe] = payload.recipes.filter { recipe in
        // Course: OR across selected courses
        if !selectedCourses.isEmpty {
          let courseName = recipe.category.description.lowercased()
          if !selectedCourses.contains(where: { courseName == $0 }) {
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
        if !q.isEmpty {
          let haystack = "\(recipe.title) \(recipe.subtitle)".lowercased()
          if !haystack.contains(q) {
            return false
          }
        }

        return true
      }

      let filteredPayload = RecipePayload(recipes: filtered)
      let data = try JSONEncoder().encode(filteredPayload)
      return try JSONDecoder().decode(T.self, from: data)
      
    default: throw NetworkServiceError.emptyResponse
    }
  }
}
