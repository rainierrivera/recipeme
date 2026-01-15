//
//  SearchField.swift
//  Test
//
//  Created by Rainier Rivera on 1/14/26.
//

enum SearchField: CaseIterable {
  case category
  case ingredients
  case servings
  
  var title: String {
    switch self {
    case .category: return "Category"
    case .ingredients: return "Ingredients"
    case .servings: return "Servings"
    }
  }
}
