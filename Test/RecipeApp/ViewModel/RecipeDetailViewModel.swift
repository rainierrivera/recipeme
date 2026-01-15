//
//  RecipeDetailViewModel.swift
//  Test
//
//  Created by Rainier Rivera on 1/14/26.
//

import SwiftUI

@MainActor
final class RecipeDetailViewModel: ObservableObject {
  
  // MARK: Public properties
  let recipe: Recipe

  // MARK: Initialization
  init(recipe: Recipe) {
    self.recipe = recipe
  }
}
