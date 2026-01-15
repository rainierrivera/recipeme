//
//  RecipeDetailView.swift
//  Test
//
//  Created by Rainier Rivera on 1/14/26.
//

import SwiftUI

struct RecipeDetailView: View {
  
  // MARK: Private properties
  @ObservedObject private var viewModel: RecipeDetailViewModel
  private var onTappedBack: () -> ()
  
  
  // MARK: Initialization
  
  init(viewModel: RecipeDetailViewModel,
       onTappedBack: @escaping () -> Void) {
    self.viewModel = viewModel
    self.onTappedBack = onTappedBack
  }
  
  // MARK: Public properties
  
  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        RecipeDetailHeaderView(
          imageName: viewModel.recipe.imageName,
          title: viewModel.recipe.title,
          description: viewModel.recipe.subtitle, // or your full description field
          durationMinutes: viewModel.recipe.durationMinutes,
          difficultyText: viewModel.recipe.difficulty,
          numberOfServings: "\(viewModel.recipe.numberOfServings)",
          likes: "\(viewModel.recipe.likes)",
          onBack: { onTappedBack() }
        )

        // rest of detail content below...
        VStack(alignment: .leading, spacing: 16) {
          VStack(spacing: 16) {
            IngredientsCardView(
              ingredients: viewModel.recipe.ingredients.map {
                "\(String(format: "%.0f", $0.quantity)) \($0.unit) \($0.name)"
              }
            )

            DirectionsCardView(
              steps: viewModel.recipe.steps.map({ step in
                var durationString = ""
                if let duration = step.duration {
                  durationString = "duration: \(duration)"
                }
                return "\(step.instruction) \n\(durationString)"
              })
            )
          }
          .padding(.top, 16)
          
          IngredientsSectionView(
            title: "Ingredients",
            ingredients: viewModel.recipe.ingredients.map {
              IngredientDisplayItem(imageName: $0.name, name: $0.name)
            }
          )
          .padding(.top, 12)
        }
        .padding(.top, 16)
      }
      .frame(maxWidth: .infinity)
    }
    .navigationBarBackButtonHidden(true) // since we have custom back button
  }
}
