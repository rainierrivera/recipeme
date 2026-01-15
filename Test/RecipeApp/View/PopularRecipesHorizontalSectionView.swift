//
//  PopularRecipesHorizontalSectionView.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

import SwiftUI

struct PopularRecipesHorizontalSectionView: View {
  let title: String
  let recipes: [Recipe]
  var onTap: ((Recipe) -> Void)? = nil

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text(title)
        .font(.title2.weight(.bold))
        .padding(.horizontal, 16)
        .foregroundStyle(Color.orange)

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 0) {
          ForEach(recipes) { recipe in
            PopularRecipeCardView(
              imageName: recipe.imageName,
              title: recipe.title,
              onTap: { onTap?(recipe) }
            )
            .frame(width: 300)
          }
        }
        .padding(.horizontal, 8)
      }
    }
  }
}

