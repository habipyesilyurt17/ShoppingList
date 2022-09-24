//
//  CategoriesViewModelDelegate.swift
//  ShoppingList
//
//  Created by Habip Yesilyurt on 23.09.2022.
//

import Foundation

protocol CategoriesViewModelDelegate {
    func saveCategory(categories: [Categories])
    func fetchCategories(categories: [Categories])
    func removeFromCategories(categories: [Categories])
}
