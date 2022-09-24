//
//  CategoriesViewModel.swift
//  ShoppingList
//
//  Created by Habip Yesilyurt on 23.09.2022.
//

import UIKit

final class CategoriesViewModel{
    
    private var categoriesViewModelDelegate: CategoriesViewModelDelegate?
    
    init(with categoriesViewModelDelegate: CategoriesViewModelDelegate?) {
        self.categoriesViewModelDelegate = categoriesViewModelDelegate
    }
    
    var categories: [Categories] = []
    
    func saveData(categoryName: String, shoppingList: ShoppingLists?) {
        let newCategory  = Categories(context: CategoriesManager.shared.context)
        newCategory.id   = UUID()
        newCategory.done = false
        newCategory.name = categoryName
        if let shoppingList = shoppingList {
            newCategory.parentList = shoppingList
        }
        CategoriesManager.shared.saveData(data: newCategory) { isSuccess, saveError in
            if isSuccess {
                self.categories.append(newCategory)
                self.categoriesViewModelDelegate?.saveCategory(categories: self.categories)
            } else {
                print("error: \(saveError)")
            }
        }
    }
    
    func fetcData(shoppingId: UUID?) {
        CategoriesManager.shared.fetchData(id: shoppingId) { response in
            switch response {
            case .success(let categories):
                self.categories = categories
                self.categoriesViewModelDelegate?.fetchCategories(categories: self.categories)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}
