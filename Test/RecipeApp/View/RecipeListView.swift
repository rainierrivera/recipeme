//
//  RecipeListView.swift
//  Test
//
//  Created by Rainier Rivera on 1/14/26.
//

import SwiftUI

struct RecipeListView: View {
  
  // MARK: Private properties
  @StateObject var viewModel: RecipeListViewModel
  
  // MARK: UI Private properties
  private let strokeColor: Color = Color.orange.opacity(0.85)
  private let strokeWidth: CGFloat = 2
  private let cornerRadius: CGFloat = 28
  
  // MARK: Initialization
  init(
    viewModel: RecipeListViewModel
  ) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }

  // MARK: public properties
  var body: some View {
    VStack {
      if viewModel.isLoading {
        HStack {
          Spacer()
          ProgressView()
          Spacer()
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
      } else {
        searchBox
        recipeList
      }
    }
    .navigationTitle("Recipes")
    .navigationBarTitleDisplayMode(.inline)
    .task {
      await viewModel.loadRecipes()
    }
  }
  
  // MARK: Private UI Views
  private var searchBox: some View {
    // create fake search box button to navigate to search screen
    Button(action: viewModel.tappedSearch) {
      VStack {
        Text("Search")
          .foregroundStyle(Color.orange)
          .frame(maxWidth: .infinity, alignment: .center)
          .frame(height: 32)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .buttonStyle(.plain)
    .overlay(
      RoundedRectangle(cornerRadius: cornerRadius,
                       style: .continuous)
        .stroke(strokeColor, lineWidth: strokeWidth)
    )
    .padding(.horizontal, 16)
  }
  
  private var popularView: some View {
    PopularRecipesHorizontalSectionView(
      title: "Popular Recipes",
      recipes: Array(
        viewModel
          .cachedRecipes()
          .sorted { $0.likes > $1.likes }
          .prefix(5)
      ),
      onTap: { recipe in
        viewModel.tappedRecipe(recipe)
      }
    )
  }
  
  private var discoverView: some View {
    if let recipe = viewModel.cachedRecipes().randomElement() {
      return AnyView(PopularRecipesSectionView(title: "Discover", recipe: recipe, onTap: {
        viewModel.tappedRecipe($0)
      }))
    } else {
      return AnyView(EmptyView())
    }
  }
  
  private var recipeList: some View {
    VStack(spacing: 0) {
      List {
        discoverView
          .listRowInsets(EdgeInsets())
          .listRowBackground(Color.clear)
          .listRowSeparator(.hidden)
        
        VStack(alignment: .leading, spacing: 8) {
          Text("Categories")
            .font(.title2.weight(.bold))
            .foregroundStyle(Color.orange)
            .padding(.leading, 16)
          
          ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
              ForEach(viewModel.sortedCategories, id: \.self) { category in
                RecipeCardView(
                  imageName: category.imageName,
                  title: category.description,
                  subtitle: ""
                )
                .frame(width: 180, height: 240)
                .onTapGesture { _ in
                  viewModel.tappedCategory(category)
                }
              }
            }
            .padding(.leading, 16)
            .background(
              RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
            )
          }
          .padding(.vertical, 12)
          .listRowInsets(EdgeInsets())
          .listRowBackground(Color.clear)
          .listRowSeparator(.hidden)
          
        }
        .padding(.vertical, 16)
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        
        popularView
          .listRowInsets(EdgeInsets())
          .listRowBackground(Color.clear)
          .listRowSeparator(.hidden)
      }
      
      if let errorMessage = viewModel.errorMessage {
        Text(errorMessage)
          .foregroundStyle(.red)
          .listRowBackground(Color.clear)
          .listRowSeparator(.hidden)
      }
    }
    .listStyle(.plain)
    .padding(.top, 24)
  }
}

