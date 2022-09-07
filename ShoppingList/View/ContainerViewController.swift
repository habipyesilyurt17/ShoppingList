//
//  ContainerViewController.swift
//  ShoppingList
//
//  Created by habip on 2.09.2022.
//

import UIKit

class ContainerViewController: UIViewController {
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let menuVC = MenuViewController()
    let shoppingListVC = ShoppingListViewController()
    var navVC: UINavigationController?
    lazy var imageVC = ImagesViewController()
    lazy var categoryVC = CategoriesViewController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
          addChildVCs()
    }
    
    private func addChildVCs() {
        // Menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        // Home
        shoppingListVC.delegate = self
        let navVC = UINavigationController(rootViewController: shoppingListVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
    
}

extension ContainerViewController: ShoppingListViewControllerDelegate {
    func didTopMenuButton() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.shoppingListVC.view.frame.size.width - 100
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }

        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}

extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        toggleMenu { [weak self] in
            switch menuItem {
            case .home:
                self?.resetToHome()
            case .categories:
                self?.addCategories()
             case .images:
                self?.addImage()
            }
        }
    }
    
    func addCategories() {
        shoppingListVC.addChild(categoryVC)
        shoppingListVC.view.addSubview(categoryVC.view)
        categoryVC.view.frame = view.frame
        categoryVC.didMove(toParent: shoppingListVC)
        shoppingListVC.title = categoryVC.title
    }
    
    func addImage() {
        shoppingListVC.addChild(imageVC)
        shoppingListVC.view.addSubview(imageVC.view)
        imageVC.view.frame = view.frame
        imageVC.didMove(toParent: shoppingListVC)
        shoppingListVC.title = imageVC.title
    }
    
    func resetToHome() {
        categoryVC.view.removeFromSuperview()
        categoryVC.didMove(toParent: nil)
        imageVC.view.removeFromSuperview()
        imageVC.didMove(toParent: nil)
        shoppingListVC.title = "Shopping List"
    }
}
