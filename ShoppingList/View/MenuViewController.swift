//
//  MenuViewController.swift
//  ShoppingList
//
//  Created by habip on 2.09.2022.
//

import UIKit

class MenuViewController: UIViewController {
    weak var delegate: MenuViewControllerDelegate?
    
    enum MenuOptions: String, CaseIterable {
        case home = "Home"
        case shoppingList = "Shopping List"
        case images = "Images"
        
        var imageName: String {
            switch self {
            case .home:
                return "house"
            case .shoppingList:
                return "list.bullet.rectangle.fill"
            case .images:
                return "photo.fill"
            }
        }
    }
    
    private let tableView: UITableView = UITableView()
    
    let grayColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = grayColor
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height )
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = nil
        setTableViewDelegate()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .white
        cell.backgroundColor = grayColor
        cell.contentView.backgroundColor = grayColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
}
