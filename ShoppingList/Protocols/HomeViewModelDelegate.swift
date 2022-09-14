//
//  HomeViewModelDelegate.swift
//  ShoppingList
//
//  Created by Habip Yesilyurt on 12.09.2022.
//

import Foundation

protocol HomeViewModelDelegate {
    func fetchShoppingLists(shoppingLists: [ShoppingLists])
}
