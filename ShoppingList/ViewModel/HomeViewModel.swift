//
//  HomeViewModel.swift
//  ShoppingList
//
//  Created by Habip Yesilyurt on 12.09.2022.
//

import Foundation

final class HomeViewModel {
    private var homeViewModelDelegate: HomeViewModelDelegate?
    
    init(with homeViewModelDelegate: HomeViewModelDelegate) {
        self.homeViewModelDelegate = homeViewModelDelegate
    }
    
    var shoppingLists: [ShoppingLists] = []
    
    
    func fetcData() {
        ShoppingListsManager.shared.fetchData { response in
            switch response {
            case .success(let shoppings):
                self.shoppingLists = shoppings
                self.homeViewModelDelegate?.fetchShoppingLists(shoppingLists: self.shoppingLists)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}
