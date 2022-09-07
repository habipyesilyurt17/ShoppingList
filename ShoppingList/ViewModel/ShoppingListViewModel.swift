//
//  ShoppingListViewModel.swift
//  ShoppingList
//
//  Created by habip on 3.09.2022.
//

import Foundation
//import CoreData

final class ShoppingListViewModel{
    
    private var shoppingListViewModelDelegate: ShoppingListViewModelDelegate?
    
    init(with shoppingListViewModelDelegate: ShoppingListViewModelDelegate?) {
        self.shoppingListViewModelDelegate = shoppingListViewModelDelegate
    }
    
    var shoppingLists: [ShoppingLists] = []
    
    func saveDatas(shoppingName: String) {
        let  newShopping = ShoppingLists(context: ShoppingListsManager.shared.context)
        newShopping.id   = UUID()
        newShopping.name = shoppingName
        ShoppingListsManager.shared.saveData(data: newShopping) { isSuccess, saveError in
            if isSuccess {
                self.shoppingLists.append(newShopping)
                self.shoppingListViewModelDelegate?.saveShoppingList(shoppingLists: self.shoppingLists)
            } else {
                print("error: \(saveError)")
            }
        }
    }
    
    func fetcData() {
        ShoppingListsManager.shared.fetchData { response in
            switch response {
            case .success(let shoppings):
                self.shoppingLists = shoppings
                self.shoppingListViewModelDelegate?.fetchShoppingLists(shoppingLists: self.shoppingLists)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func removeData(id: UUID?, index: Int) {
        if let id = id {
            ShoppingListsManager.shared.removeData(id: id) { isSuccess, deleteError in
                if isSuccess {
                    self.shoppingLists.remove(at: index)
                    self.shoppingListViewModelDelegate?.removeFromShoppingLists(shoppingLists: self.shoppingLists)
                } else {
                    print("error: \(deleteError)")
                }
            }
        }
    }

}
