//
//  RecipeAPI.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

import Foundation

// MARK: - Endpoints

enum RecipeAPI: NetworkProvider {

  case fetchRecipes
  case search(categories: [String], ingredients: [String], servings: [Int], query: String)

  var baseURL: String {
    // This is a mock backend base URL. Replace with real base URL later.
    "https://example.local"
  }

  var path: String {
    switch self {
    case .fetchRecipes:
      return "/recipes"

    case .search:
      return "/recipes/search"
    }
  }

  var method: NetworkMethod {
    switch self {
    case .fetchRecipes, .search:
      return .get
    }
  }

  var parameters: [URLQueryItem]? {
    switch self {
    case .fetchRecipes:
      return nil

    case let .search(course, ingredients, servings, query):
      let q = query.trimmingCharacters(in: .whitespacesAndNewlines)

      var items: [URLQueryItem] = []

      for c in course {
        let value = c.trimmingCharacters(in: .whitespacesAndNewlines)
        if !value.isEmpty {
          items.append(URLQueryItem(name: "course", value: value))
        }
      }

      for ing in ingredients {
        let value = ing.trimmingCharacters(in: .whitespacesAndNewlines)
        if !value.isEmpty {
          items.append(URLQueryItem(name: "ingredient", value: value))
        }
      }

      for s in servings {
        items.append(URLQueryItem(name: "servings", value: String(s)))
      }

      if !q.isEmpty {
        items.append(URLQueryItem(name: "q", value: q))
      }

      return items.isEmpty ? nil : items
    }
  }

  var body: (any Encodable)? {
    nil
  }

  var mockData: Data? {
    // Leave nil to use the default local-json behavior in Networkservice.
    nil
  }
}
