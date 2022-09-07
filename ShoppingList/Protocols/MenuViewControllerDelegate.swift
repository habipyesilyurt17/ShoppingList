//
//  MenuViewControllerDelegate.swift
//  ShoppingList
//
//  Created by habip on 2.09.2022.
//

import Foundation

protocol MenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: MenuViewController.MenuOptions)
}
