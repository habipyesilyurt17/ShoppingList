//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by habip on 2.09.2022.
//

import UIKit
import CoreData

class ShoppingListViewController: UIViewController {
    private lazy var shoppingLists: [ShoppingLists] = []
    private let tableView: UITableView = UITableView()
    
    // burada delegate menu tasarımı için olan kısımdı burayı kontrol edecem
    weak var delegate: ShoppingListViewControllerDelegate?

    lazy var shoppingListViewModel = ShoppingListViewModel(with: self)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        view.backgroundColor = .systemBackground
        title = "Shopping List"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(didTopMenuButton))
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        shoppingListViewModel.fetcData()
    }

    @objc func didTopMenuButton() {
        delegate?.didTopMenuButton()
    }
    
    
    @objc fileprivate func addButtonClicked() {
        alertWithTextField(with: "Create New Shopping", "", "Add", "Cancel", "Enter shopping name") { text in
            self.shoppingListViewModel.saveDatas(shoppingName: text)
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
        setTableViewDelegate()
        tableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: ShoppingListTableViewCell.Identifier.custom.rawValue)
        setTableViewConstraints()
    }
    
    private func setTableViewDelegate() {
//        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension ShoppingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.Identifier.custom.rawValue) as! ShoppingListTableViewCell
        cell.set(shopping: shoppingLists[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let selectedShoppingId = shoppingLists[indexPath.row].id
            shoppingListViewModel.removeData(id: selectedShoppingId, index: indexPath.row)
        }
    }
}
