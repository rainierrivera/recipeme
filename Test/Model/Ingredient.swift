//
//  Ingredient.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

struct Ingredient: Codable, Hashable {
  let name: String
  let quantity: Double
  let unit: String
  let category: IngredientCategory
  let notes: String?
}

extension IngredientCategory {
  static var allDescriptions: [String] {
    IngredientCategory.allCases.map { $0.description }
  }
}

