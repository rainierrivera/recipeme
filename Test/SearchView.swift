//
//  SearchView.swift
//  Test
//
//  Created by Rainier Rivera on 1/14/26.
//

import SwiftUI

struct SearchListView: View {
  @StateObject var viewModel: SearchViewModel

  init(viewModel: SearchViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }

  var body: some View {
    VStack {
      if viewModel.isLoading {
        HStack {
          Spacer()
          ProgressView()
          Spacer()
        }
        .padding(.vertical, 16)
      }
      
        VStack(alignment: .leading, spacing: 16) {
          SearchBar(text: $viewModel.query,
                    placeholder: "Search your recipes")
          .padding(.horizontal)
          
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
              ForEach(SearchField.allCases, id: \.self) { field in
                FilterChip(
                  title: field.title,
                  value: viewModel.displayValue(for: field),
                  showsChevron: true,
                  action: { viewModel.didTapPill(field: field) }
                )
              }
            }
            .padding(.horizontal)
          }
          
          ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
              ForEach(viewModel.filteredSortedCategories, id: \.self) { course in
                let recipes = viewModel.filteredGroupedRecipes[course] ?? []
                
                VStack(alignment: .leading, spacing: 12) {
                  Text(course.description)
                    .font(.headline)
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 16)
                  
                  ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 12) {
                      ForEach(recipes, id: \.id) { recipe in
                        Button {
                          viewModel.selectedRecipe(item: recipe)
                        } label: {
                          RecipeCardView(
                            imageName: recipe.imageName,
                            title: recipe.title,
                            subtitle: recipe.subtitle
                          )
                          .frame(width: 180, height: 240)
                        }
                        .buttonStyle(.plain)
                      }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                  }
                  .background(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                      .fill(Color.white)
                  )
                }
                .padding(.vertical, 12)
              }
              
              // just show simple loading
              if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                  .foregroundStyle(.red)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 16)
              }
              
              if !viewModel.isLoading, viewModel.errorMessage == nil, viewModel.filteredSortedCategories.isEmpty {
                Text("No results")
                  .foregroundStyle(.secondary)
                  .padding(.horizontal, 16)
                  .padding(.vertical, 16)
              }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
          }
        }
        .padding(.top, 8)
    }
    .navigationTitle("Recipes")
    .navigationBarTitleDisplayMode(.inline)
    .sheet(isPresented: $viewModel.isSearchFieldSheetPresented) {
      NavigationStack {
        SearchItemView(
          viewModel: SearchListViewModel(
            recipes: viewModel.cachedRecipes(),
            field: viewModel.currentField,
            initiallySelected: viewModel.selectedItems(for: viewModel.currentField),
            onDone: { selected in
              viewModel.setSelectedSearch(selected, for: viewModel.currentField)
              viewModel.isSearchFieldSheetPresented = false
            },
            onCancel: {
              viewModel.isSearchFieldSheetPresented = false
            }
          )
        )
      }
    }
    .task {
      viewModel.loadRecipesIfNeeded()
    }
  }
}

