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
        categoriesViewModel.fetchData(shoppingId: selectedShoppingList?.id)
    }
    
    @objc fileprivate func addButtonPressed() {
        alertWithTextField(with: "Create New Category", "", "Add", "Cancel", "Enter category name", nil) { text in
            self.categoriesViewModel.saveData(categoryName: text, shoppingList: self.selectedShoppingList)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("\(self.categories)")
    }
}

extension CategoriesViewController {
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.rowHeight = 45
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // go to items vc
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: nil) { action, view, complete in
            let selectedCategory = self.categories[indexPath.row].name
            self.alertWithTextField(with: "Update Category", "", "Edit", "Cancel", nil, selectedCategory) { text in
                let updatedCategory = text
                let categoryId = self.categories[indexPath.row].id
                self.categoriesViewModel.updateData(id: categoryId, index: indexPath.row, updatedText: updatedCategory)
            }
            complete(true)
        }
        let deleteAction = UIContextualAction(style: .normal, title: nil) { action, view, complete in
            let shoppingId = self.categories[indexPath.row].id
            self.categoriesViewModel.removeData(id: shoppingId, index: indexPath.row)
            complete(true)
        }
        editAction.image = UIImage(systemName: "square.and.pencil")?.colored(in: .white)
        editAction.backgroundColor = .blue
        deleteAction.image = UIImage(systemName: "trash.fill")?.colored(in: .white)
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])

    }
}
