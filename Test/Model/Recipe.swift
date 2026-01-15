//
//  Recipe.swift
//  Test
//
//  Created by Rainier Rivera on 1/10/26.
//

import Foundation

struct RecipesResponse: Codable {
  let recipes: [Recipe]
}

struct Recipe: Codable, Identifiable, Hashable {
  let id: Int
  let title: String
  let subtitle: String
  let imageName: String
  let category: Category
  let numberOfServings: Int
  let likes: Int
  let difficulty: String
  let durationMinutes: Int?
  let ingredients: [Ingredient]
  let steps: [RecipeStep]
}
