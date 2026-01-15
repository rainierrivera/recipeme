//
//  RecipeCardView.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

import SwiftUI

struct RecipeCardView: View {
  let imageName: String
  let title: String
  let subtitle: String

  var body: some View {
    ZStack(alignment: .bottomLeading) {
      Image(imageName, bundle: .main)
        .resizable()
        .scaledToFill()
        .frame(width: 180, height: 240)
        .clipped()

      LinearGradient(
        gradient: Gradient(colors: [
          Color.black.opacity(0.75),
          Color.black.opacity(0.0)
        ]),
        startPoint: .bottom,
        endPoint: .top
      )
      .frame(height: 90)
      .frame(maxWidth: .infinity)

      VStack(alignment: .leading, spacing: 6) {
        Text(title)
          .font(.headline)
          .foregroundStyle(.white)
          .lineLimit(1)

        Text(subtitle)
          .font(.subheadline)
          .foregroundStyle(.white.opacity(0.9))
          .lineLimit(1)

      }
      .padding(.horizontal, 12)
      .padding(.bottom, 12)
    }
    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    .contentShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
  }
}
