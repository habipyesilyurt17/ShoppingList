//
//  ShoppingListViewModelDelegate.swift
//  ShoppingList
//
//  Created by habip on 3.09.2022.
//

import Foundation

protocol ShoppingListViewModelDelegate {
    func saveShoppingList(shoppingLists: [ShoppingLists])
    func fetchShoppingLists(shoppingLists: [ShoppingLists])
    func removeFromShoppingLists(shoppingLists: [ShoppingLists])
}
