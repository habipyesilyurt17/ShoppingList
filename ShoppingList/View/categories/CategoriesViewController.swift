//
//  CategoriesViewController.swift
//  ShoppingList
//
//  Created by habip on 2.09.2022.
//

import UIKit

class CategoriesViewController: UIViewController {
    var selectedShoppingList: ShoppingLists? {
        didSet {
            loadCategories()
        }
    }
    var categories: [Categories] = []
    private var tableView: UITableView = UITableView()
    lazy var categoriesViewModel = CategoriesViewModel(with: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedShoppingList = selectedShoppingList {
            title = "\(selectedShoppingList.name!) Categories"
        } else {
            title = "Categories"
        }
        view.backgroundColor = UIColor().getAppCustomColor()
        configureTableView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonPressed))
    }
    
    func loadCategories() {
        categoriesViewModel.fetcData(shoppingId: selectedShoppingList?.id)
    }
    
    @objc fileprivate func addButtonPressed() {
        alertWithTextField(with: "Create New Category", "", "Add", "Cancel", "Enter category name", nil) { text in
            self.categoriesViewModel.saveData(categoryName: text, shoppingList: self.selectedShoppingList)
        }
    }
}

extension CategoriesViewController {
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor().getAppCustomColor()
        setTableViewDelegate()
    }
    
    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.Identifier.custom.rawValue)
        setTableViewConstraints()
    }
    
    private func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension CategoriesViewController: CategoriesViewModelDelegate {
    func saveCategory(categories: [Categories]) {
        self.categories = categories
        tableView.reloadData()
    }
    
    func fetchCategories(categories: [Categories]) {
        self.categories = categories
        tableView.reloadData()
    }
    
    func removeFromCategories(categories: [Categories]) {
        self.categories = categories
        tableView.reloadData()
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.Identifier.custom.rawValue) as? CategoriesTableViewCell
        guard let cell = cell else { return UITableViewCell() }
        cell.set(category: categories[indexPath.row])
        return cell
    }
}
