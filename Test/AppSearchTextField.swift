//
//  AppSearchTextField.swift
//  Test
//
//  Created by Rainier Rivera on 1/14/26.
//

import SwiftUI

struct AppSearchTextField: View {
  @Binding var text: String
  var placeholder: String

  var iconSystemName: String = "magnifyingglass"
  var showsClearButton: Bool = true
  var strokeColor: Color = Color.orange.opacity(0.85)
  var strokeWidth: CGFloat = 2
  var cornerRadius: CGFloat = 28

  @FocusState private var isFocused: Bool

  init(
    text: Binding<String>,
    placeholder: String,
    iconSystemName: String = "magnifyingglass",
    showsClearButton: Bool = true,
    strokeColor: Color = Color.orange.opacity(0.85),
    strokeWidth: CGFloat = 2,
    cornerRadius: CGFloat = 28
  ) {
    _text = text
    self.placeholder = placeholder
    self.iconSystemName = iconSystemName
    self.showsClearButton = showsClearButton
    self.strokeColor = strokeColor
    self.strokeWidth = strokeWidth
    self.cornerRadius = cornerRadius
  }

  var body: some View {
    HStack(spacing: 10) {
      Image(systemName: iconSystemName)
        .foregroundStyle(.secondary)

      ZStack(alignment: .leading) {
        if text.isEmpty {
          Text(placeholder)
            .foregroundStyle(.secondary)
        }

        TextField("", text: $text)
          .focused($isFocused)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
          .submitLabel(.search)
      }

      if showsClearButton, !text.isEmpty {
        Button {
          text = ""
        } label: {
          Image(systemName: "xmark.circle.fill")
            .foregroundStyle(.secondary)
        }
        .buttonStyle(.plain)
      }
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 14)
    .background(
      RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        .fill(Color(.systemBackground))
    )
    .overlay(
      RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        .stroke(strokeColor, lineWidth: strokeWidth)
    )
    .shadow(color: strokeColor.opacity(0.22), radius: 10, x: 0, y: 2)
    .padding(.horizontal)
  }
}
