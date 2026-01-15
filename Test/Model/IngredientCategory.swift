//
//  IngredientCategory.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

enum IngredientCategory: Int, Codable, CaseIterable, CustomStringConvertible {
  case beefAndPork = 1
  case poultry = 2
  case seafood = 3
  case vegetarian = 4
  case fruitsAndVegetable = 5
  case eggsAndDairy = 6
  case condiments = 7
  case others = 999
  
  init(category: Int) {
    self = IngredientCategory(rawValue: category) ?? .others
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let rawValue = (try? container.decode(Int.self)) ?? IngredientCategory.others.rawValue
    self = IngredientCategory(rawValue: rawValue) ?? .others
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawValue)
  }

  var description: String {
    switch self {
    case .beefAndPork:
      return "Beef and Pork"

    case .poultry:
      return "Poultry"

    case .seafood:
      return "Seafood"

    case .vegetarian:
      return "Vegetarian"

    case .fruitsAndVegetable:
      return "Fruits and Vegetable"

    case .eggsAndDairy:
      return "Eggs & Dairy"

    case .condiments:
      return "Condiments"
      
    case .others:
      return "Others"
    }
  }
}
