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
    let homeVC = HomeViewController()
    var navVC: UINavigationController?
    
    lazy var shoppingListVC  = ShoppingListViewController()
    lazy var imageVC    = ImagesViewController()
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
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
    
}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTopMenuButton() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
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
            case .shoppingList:
                self?.addShoppingList()
             case .images:
                self?.addImage()
            }
        }
    }
    
    func addShoppingList() {
        homeVC.addChild(shoppingListVC)
        homeVC.view.addSubview(shoppingListVC.view)
        shoppingListVC.view.frame = view.frame
        shoppingListVC.didMove(toParent: homeVC)
        shoppingListVC.shoppingListViewIsLoad()
        homeVC.title = shoppingListVC.title
    }
    
    func addImage() {
        homeVC.addChild(imageVC)
        homeVC.view.addSubview(imageVC.view)
        imageVC.view.frame = view.frame
        imageVC.didMove(toParent: homeVC)
        imageVC.imagesViewIsLoad()
        homeVC.title = imageVC.title
    }
    
    func resetToHome() {
        shoppingListVC.view.removeFromSuperview()
        shoppingListVC.didMove(toParent: nil)
        imageVC.view.removeFromSuperview()
        imageVC.didMove(toParent: nil)
        homeVC.title = "Home"
        homeVC.homeViewIsLoad()
    }
}
