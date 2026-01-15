//
//  DirectionsCardView.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

import SwiftUI

struct DirectionsCardView: View {
  let steps: [String]

  var body: some View {
    RecipeSectionCard(title: "Directions") {
      VStack(alignment: .leading, spacing: 16) {
        ForEach(steps.indices, id: \.self) { index in
          VStack(alignment: .leading, spacing: 6) {
            Text("Step \(index + 1)")
              .font(.subheadline.weight(.semibold))

            Text(steps[index])
              .font(.body)
              .foregroundStyle(.primary)
          }
        }
      }
    }
  }
}
