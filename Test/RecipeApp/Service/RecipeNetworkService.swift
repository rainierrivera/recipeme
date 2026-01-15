//
//  RecipeNetworkService.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

import Foundation

// MARK: - Service

final class RecipeNetworkService: RecipeNetworkType {
  private let service: Network

  init(service: Network = MockNetworkService()) {
    self.service = service
  }

  func fetchAllRecipes() async throws -> [Recipe] {
    let endpoint: NetworkProvider = RecipeAPI.fetchRecipes
    let payload = try await service.request(endpoint, responseType: RecipePayload.self)
    return payload.recipes
  }

  func searchRecipes(categories: [String], ingredients: [String], servings: [Int], queryText: String) async throws -> [Recipe] {
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
