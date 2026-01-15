//
//  Untitled.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

import SwiftUI

struct PopularRecipesSectionView: View {
  let title: String
  let recipe: Recipe
  var onTap: ((Recipe) -> Void)? = nil

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text(title)
        .font(.title2.weight(.bold))
        .foregroundStyle(Color.orange)
        .padding(.horizontal, 16)

      PopularRecipeCardView(
        imageName: recipe.imageName,
        title: recipe.title,
        onTap: { onTap?(recipe) }
      )
      .padding(.horizontal, 16)
    }
  }
}
