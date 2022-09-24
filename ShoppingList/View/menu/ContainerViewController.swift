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
    lazy var shoppingListVC = ShoppingListViewController()
    lazy var imageVC        = ImagesViewController()
    var navVC: UINavigationController?

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
            case .shoppingList:
                self?.resetToShoppingList()
             case .images:
                self?.addImage()
            }
        }
    }
    
    func addImage() {
        shoppingListVC.addChild(imageVC)
        shoppingListVC.view.addSubview(imageVC.view)
        imageVC.view.frame = view.frame
        imageVC.didMove(toParent: shoppingListVC)
        imageVC.imagesViewIsLoad()
        shoppingListVC.title = imageVC.title
    }
    
    func resetToShoppingList() {
        imageVC.view.removeFromSuperview()
        imageVC.didMove(toParent: nil)
        shoppingListVC.title = "Shopping List"
        shoppingListVC.shoppingListViewIsLoad()
    }
}
