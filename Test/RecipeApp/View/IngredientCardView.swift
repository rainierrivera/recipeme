//
//  IngredientCardView.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

import SwiftUI

struct IngredientCardView: View {
  let imageName: String
  let name: String

  var body: some View {
    VStack(spacing: 8) {
      Image(imageName)
        .resizable()
        .scaledToFill()
        .frame(width: 74, height: 74)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

      Text(name)
        .font(.caption)
        .foregroundStyle(.secondary)
        .lineLimit(1)
        .frame(width: 74)
    }
  }
}
