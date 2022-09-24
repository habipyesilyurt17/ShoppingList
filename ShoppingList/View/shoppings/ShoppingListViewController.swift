//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by habip on 2.09.2022.
//

import UIKit

class ShoppingListViewController: UIViewController {
    weak var delegate: ShoppingListViewControllerDelegate?
    private lazy var shoppingLists: [ShoppingLists] = []
    private let tableView: UITableView = UITableView()
    lazy var shoppingListViewModel = ShoppingListViewModel(with: self)
    
    func crateNavigationAddButton() {
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor().getAppCustomColor()
        title = "Shopping List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(didTopMenuButton))
        crateNavigationAddButton()
        configureTableView()
        shoppingListViewModel.fetcData()
        
    }
    
    @objc func didTopMenuButton() {
        delegate?.didTopMenuButton()
    }

    func shoppingListViewIsLoad() {
        crateNavigationAddButton()
    }
    
    @objc fileprivate func addButtonClicked() {
        alertWithTextField(with: "Create New Shopping", "", "Add", "Cancel", "Enter shopping name", nil) { text in
            self.shoppingListViewModel.saveDatas(shoppingName: text)
            NotificationCenter.default.post(name: NSNotification.Name("changeData"), object: nil)
        }
    }

}

extension ShoppingListViewController: ShoppingListViewModelDelegate {
    func saveShoppingList(shoppingLists: [ShoppingLists]) {
        self.shoppingLists = shoppingLists
        tableView.reloadData()
    }
    
    func fetchShoppingLists(shoppingLists: [ShoppingLists]) {
        self.shoppingLists = shoppingLists
        tableView.reloadData()
    }
    
    func removeFromShoppingLists(shoppingLists: [ShoppingLists]) {
        self.shoppingLists = shoppingLists
        tableView.reloadData()
    }
    
}

//MARK: - Configuration UI
extension ShoppingListViewController {
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor().getAppCustomColor()
        setTableViewDelegate()
        tableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: ShoppingListTableViewCell.Identifier.custom.rawValue)
        setTableViewConstraints()
    }
    
    
    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension ShoppingListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.Identifier.custom.rawValue) as! ShoppingListTableViewCell
        cell.set(shopping: shoppingLists[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoriesVC = CategoriesViewController()
        let choosenShoppingList = shoppingLists[indexPath.row]
        categoriesVC.selectedShoppingList = choosenShoppingList
        navigationController?.pushViewController(categoriesVC, animated: true)
    }


    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: nil) { action, view, complete in
            let selectedShopping = self.shoppingLists[indexPath.row].name
            self.alertWithTextField(with: "Update Shopping", "", "Edit", "Cancel", nil, selectedShopping) { text in
                let updatedShopping = text
                let shoppingId = self.shoppingLists[indexPath.row].id
                self.shoppingListViewModel.updateData(id: shoppingId, index: indexPath.row, updatedText: updatedShopping)
            }
            complete(true)
        }
        let deleteAction = UIContextualAction(style: .normal, title: nil) { action, view, complete in
            let shoppingId = self.shoppingLists[indexPath.row].id
            self.shoppingListViewModel.removeData(id: shoppingId, index: indexPath.row)
            NotificationCenter.default.post(name: NSNotification.Name("changeData"), object: nil)
            complete(true)
        }
        editAction.image = UIImage(systemName: "square.and.pencil")?.colored(in: .white)
        editAction.backgroundColor = .blue
        deleteAction.image = UIImage(systemName: "trash.fill")?.colored(in: .white)
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}
