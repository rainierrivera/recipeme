//
//  IngredientsSectionView.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

import SwiftUI

struct IngredientsSectionView: View {
  let title: String
  let ingredients: [IngredientDisplayItem]

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack {
        Text(title)
          .font(.headline)
          .foregroundStyle(.primary)

        Spacer()

        Text("\(ingredients.count) Ingredients")
          .font(.subheadline)
          .foregroundStyle(.secondary)
      }
      .padding(.horizontal, 16)

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 14) {
          ForEach(ingredients) { item in
            IngredientCardView(
              imageName: item.imageName,
              name: item.name
            )
          }
        }
        .padding(.horizontal, 16)
      }
    }
  }
}
