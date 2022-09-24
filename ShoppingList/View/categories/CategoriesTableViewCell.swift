//
//  CategoriesTableViewCell.swift
//  ShoppingList
//
//  Created by Habip Yesilyurt on 22.09.2022.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    private let checkbox: CheckboxButton = CheckboxButton()
    var categoryLabel: UILabel = UILabel()
    
    enum Identifier: String {
        case custom = "CategoriesViewCell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(checkbox)
        configureCheckBox()
        contentView.addSubview(categoryLabel)
        configureCategoryLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(category: Categories) {
        categoryLabel.text = category.name
    }
    
    private func configureCheckBox() {
        checkbox.frame = CGRect(x: 10, y: 3, width: 40, height: 40)
        checkbox.backgroundColor = .white
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTopCheckbox))
        checkbox.addGestureRecognizer(gesture)
    }
    
    @objc private func didTopCheckbox() {
        checkbox.toggle()
        // burada viewmodele
    }
    
    private func configureCategoryLabel() {
        categoryLabel.numberOfLines = 2
        categoryLabel.adjustsFontSizeToFitWidth = false
        categoryLabel.lineBreakMode = .byTruncatingTail
        categoryLabel.font = .boldSystemFont(ofSize: 14)
        setCategoryLabelConstraints()
    }

    private func setCategoryLabelConstraints() {
//        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
//        categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
//        categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
//
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 10).isActive = true
    }
}
