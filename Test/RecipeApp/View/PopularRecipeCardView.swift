//
//  PopularRecipeCardView.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

import SwiftUI

struct PopularRecipeCardView: View {
  let imageName: String
  let title: String
  var onTap: (() -> Void)? = nil

  var body: some View {
    Button {
      onTap?()
    } label: {
      VStack(alignment: .leading, spacing: 10) {
        Image(imageName)
          .resizable()
          .scaledToFill()
          .frame(height: 180)
          .frame(maxWidth: .infinity)
          .clipped()
          .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))

        Text(title)
          .font(.subheadline.weight(.semibold))
          .foregroundStyle(.primary)
          .foregroundStyle(Color.gray)
          .lineLimit(2)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(8)
      .background(Color.clear)
      .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
      .shadow(color: .black.opacity(0.06), radius: 10, y: 6)
    }
    .buttonStyle(.plain)
  }
}
