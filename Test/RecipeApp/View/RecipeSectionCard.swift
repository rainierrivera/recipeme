//
//  RecipeSectionCard.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

import SwiftUI

// Since Sections are reusable layout
// RecipeSectionCard will handle the title of the section
// Just inject content: View
struct RecipeSectionCard<Content: View>: View {
  let title: String
  let content: Content

  init(
    title: String,
    @ViewBuilder content: () -> Content
  ) {
    self.title = title
    self.content = content()
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text(title.uppercased())
        .font(.caption.weight(.semibold))
        .foregroundStyle(.orange)

      Divider()

      content
    }
    .padding(16)
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    .shadow(color: .black.opacity(0.05), radius: 6, y: 3)
    .padding(.horizontal, 16)
  }
}
