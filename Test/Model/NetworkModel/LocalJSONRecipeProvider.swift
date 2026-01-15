//
//  LocalJSONRecipeProvider.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

import Foundation

final class LocalJSONRecipeProvider {
  private let fileName: String
  private let bundle: Bundle

  init(fileName: String = "recipes", bundle: Bundle = .main) {
    self.fileName = fileName
    self.bundle = bundle
  }

  func loadRecipes() throws -> [Recipe] {
    guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
      throw LocalJSONError.fileNotFound("\(fileName).json")
    }

    let data = try Data(contentsOf: url)
    let decoder = JSONDecoder()

    do {
      let payload = try decoder.decode(RecipePayload.self, from: data)
      return payload.recipes
    } catch {
      throw LocalJSONError.decodeFailed
    }
  }
}
