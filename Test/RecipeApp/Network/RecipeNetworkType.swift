//
//  RecipeNetworkService.swift
//  Test
//
//  Created by Rainier Rivera on 1/13/26.
//

import Foundation

protocol RecipeNetworkType {
  func fetchAllRecipes() async throws -> [Recipe]
  func searchRecipes(categories: [String], ingredients: [String], servings: [Int], queryText: String) async throws -> [Recipe]
}
