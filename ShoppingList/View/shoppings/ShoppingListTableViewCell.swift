//
//  ShoppingListTableViewCell.swift
//  ShoppingList
//
//  Created by habip on 4.09.2022.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {
    private let shoppingLabel: UILabel = UILabel()
    
    enum Identifier: String {
        case custom = "ShoppingViewCell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(shoppingLabel)
        configureShoppingLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(shopping: ShoppingLists) {
        shoppingLabel.text = shopping.name
    }
    
    private func configureShoppingLabel() {
        shoppingLabel.numberOfLines = 2
        shoppingLabel.adjustsFontSizeToFitWidth = false
        shoppingLabel.lineBreakMode = .byTruncatingTail
        shoppingLabel.font = .boldSystemFont(ofSize: 14)
        setShoppingLabelConstraints()
    }
    
    private func setShoppingLabelConstraints() {
        shoppingLabel.translatesAutoresizingMaskIntoConstraints = false
        shoppingLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        shoppingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        shoppingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }

}
