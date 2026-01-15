//
//  FilterChip.swift
//  Test
//
//  Created by Rainier Rivera on 1/14/26.
//

import SwiftUI

// Use for search categories
struct FilterChip: View {
  let title: String
  let value: String
  let showsChevron: Bool
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      HStack(spacing: 10) {
        VStack(alignment: .leading, spacing: 2) {
          Text(title)
            .font(.headline)

          if !value.isEmpty {
            Text(value)
              .font(.subheadline)
              .foregroundStyle(.secondary)
              .lineLimit(1)
          }
        }

        if showsChevron {
          Image(systemName: "chevron.down")
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .padding(.leading, 2)
        }
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 12)
      .background(
        Capsule(style: .continuous)
          .fill(Color(.systemBackground))
      )
      .overlay(
        Capsule(style: .continuous)
          .stroke(Color(.systemGray4), lineWidth: 1)
      )
    }
    .buttonStyle(.plain)
  }
}
