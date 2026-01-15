//
//  RecipeCoordinator.swift
//  Test
//
//  Created by Rainier Rivera on 1/14/26.
//

@MainActor
class RecipeCoordinator: Coordinator {

  func start() {
    root(view: RecipeListView(viewModel: RecipeListViewModel(onSelectRecipe: { [weak self] recipe in
      self?.showDetail(recipe)
    }, onSelectCategory: {  [weak self] category in
      self?.showSearch(seletedCategory: category)
    }, onSelectSearch: { [weak self] in
      self?.showSearch()
    })))
  }
  
  // MARK: Private Methods
  
  private func showDetail(_ recipe: Recipe) {
    push(view: RecipeDetailView(viewModel: RecipeDetailViewModel(recipe: recipe), onTappedBack: { [weak self] in
      self?.pop()
    }))
  }
  
  private func showSearch(seletedCategory: Category? = nil) {
    push(view: SearchListView(viewModel: SearchViewModel(selectedCategory: seletedCategory,
                                                         onSelectRecipe: { [weak self] recipe in
      self?.push(view: RecipeDetailView(viewModel: RecipeDetailViewModel(recipe: recipe), onTappedBack: { [weak self] in
        self?.pop()
      }))
    })))
  }
}
