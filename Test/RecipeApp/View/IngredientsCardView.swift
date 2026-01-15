//
//  IngredientsCardView.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

import SwiftUI

struct IngredientsCardView: View {
  let ingredients: [String]

  var body: some View {
    RecipeSectionCard(title: "Ingredients") {
      VStack(alignment: .leading, spacing: 8) {
        ForEach(ingredients, id: \.self) { ingredient in
          Text("• \(ingredient)")
            .font(.body)
        }
      }
    }
  }
}
