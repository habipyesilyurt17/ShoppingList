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
    var categoryId: UUID?
    var categoryIndex: Int?
    var categoriesViewModel = CategoriesViewModel(with: nil)
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
//        categoryId = category.id
//        categoryIndex = index
//        categoriesViewModel = viewModel
    }
    
    private func configureCheckBox() {
        checkbox.frame = CGRect(x: 10, y: 3, width: 40, height: 40)
        checkbox.backgroundColor = .white
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTopCheckbox))
        checkbox.addGestureRecognizer(gesture)
    }
    
    @objc private func didTopCheckbox() {
        checkbox.toggle()
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: categoryLabel.text!)
        if checkbox.isChecked {
            checkedText(attributeString: attributeString)
            //categoriesViewModel.updateData(id: categoryId, index: categoryIndex!, updatedText: categoryLabel.text, isDone: true)
        } else {
            uncheckedText(attributeString: attributeString)
            //categoriesViewModel.updateData(id: categoryId, index: categoryIndex!, updatedText: categoryLabel.text, isDone: false)
        }
    }
    
    private func checkedText(attributeString: NSMutableAttributedString) {
        attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(.strikethroughColor, value: UIColor.systemGreen, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(.foregroundColor, value: UIColor.systemGray, range: NSMakeRange(0, attributeString.length))
    }
    
    private func uncheckedText(attributeString: NSMutableAttributedString) {
        attributeString.addAttribute(.strikethroughStyle, value: 0, range: NSMakeRange(0, attributeString.length))
    }
    
    private func configureCategoryLabel() {
        categoryLabel.numberOfLines = 2
        categoryLabel.adjustsFontSizeToFitWidth = false
        categoryLabel.lineBreakMode = .byTruncatingTail
        categoryLabel.font = .boldSystemFont(ofSize: 14)
        setCategoryLabelConstraints()
    }

    private func setCategoryLabelConstraints() {
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 10).isActive = true
    }
}
