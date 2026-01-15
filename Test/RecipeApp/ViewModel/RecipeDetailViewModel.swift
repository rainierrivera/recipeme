//
//  RecipeDetailViewModel.swift
//  Test
//
//  Created by Rainier Rivera on 1/14/26.
//

import SwiftUI

@MainActor
final class RecipeDetailViewModel: ObservableObject {
  let recipe: Recipe

  init(recipe: Recipe) {
    self.recipe = recipe
  }
}
