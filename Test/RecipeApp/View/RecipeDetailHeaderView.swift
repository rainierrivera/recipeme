//
//  RecipeDetailHeaderView.swift
//  Test
//
//  Created by Rainier Rivera on 1/15/26.
//

import SwiftUI

struct RecipeDetailHeaderView: View {
  let imageName: String
  let title: String
  let description: String
  let durationMinutes: Int?
  let difficultyText: String
  let numberOfServings: String
  let likes: String

  let onBack: () -> Void

  var body: some View {
    VStack(spacing: 0) {
      GeometryReader { proxy in
        ZStack(alignment: .topLeading) {
          Image(imageName, bundle: .main)
            .resizable()
            .scaledToFill()
            .frame(width: proxy.size.width, height: 360)
            .clipped()
            .ignoresSafeArea(edges: .top)
            .padding(.top, -62) // force to top the image covering status bar

          Button(action: onBack) {
            Image(systemName: "chevron.left")
              .font(.headline)
              .foregroundStyle(.white)
              .frame(width: 44, height: 44)
              .background(.black.opacity(0.25))
              .clipShape(Circle())
          }
          .padding(.leading, 16)
          .padding(.top, 0)
        }
      }
      .frame(height: 360)

      VStack(alignment: .leading, spacing: 12) {
        Text(title)
          .font(.title3.weight(.semibold))
          .foregroundStyle(Color.orange)
          .foregroundStyle(.primary)

        Text(description)
          .font(.subheadline)
          .foregroundStyle(.secondary)
          .lineLimit(3)

        HStack(spacing: 12) {
          if let timeText = durationMinutes {
            Label("\(timeText)min", systemImage: "clock")
              .font(.subheadline)
              .foregroundStyle(.secondary)
          }
          
          Label(difficultyText, systemImage: "flame")
            .font(.subheadline)
            .foregroundStyle(.secondary)
          
          Label(numberOfServings, systemImage: "fork.knife.circle")
            .font(.subheadline)
            .foregroundStyle(.secondary)
          
          Label(likes, systemImage: "heart")
            .font(.subheadline)
            .foregroundStyle(.secondary)
          Spacer()
        }
      }
      .padding(16)
      .background(Color.white)
      .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
      .shadow(color: .black.opacity(0.08), radius: 10, y: 6)
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 16)
      .padding(.top, -32)
    }
    .ignoresSafeArea(edges: .top)
    .frame(maxWidth: .infinity)
  }
}
