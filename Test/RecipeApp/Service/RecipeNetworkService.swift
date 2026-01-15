//
//  RecipeNetworkService.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

import Foundation

// MARK: - Service
// This will be use by the viewModel
final class RecipeNetworkService: RecipeNetworkType {
  private let service: Network

  // will inject the MockNetService
  // this is now Testable for unit testing in the future...
  init(service: Network = MockNetworkService()) {
    self.service = service
  }

  // just fetch all recipes locally
  func fetchAllRecipes() async throws -> [Recipe] {
    let endpoint: NetworkProvider = RecipeAPI.fetchRecipes
    let payload = try await service.request(endpoint, responseType: RecipePayload.self)
    return payload.recipes
  }

  // logic for searching specific recipe is in the MockNetworkService...
  func searchRecipes(categories: [String],
                     ingredients: [String],
                     servings: [Int],
                     queryText: String) async throws -> [Recipe] {
    
    let endpoint: NetworkProvider = RecipeAPI.search(
      categories: categories,
      ingredients: ingredients,
      servings: servings,
      query: queryText
    )
    let payload = try await service.request(endpoint, responseType: RecipePayload.self)

    return payload.recipes
  }
}
