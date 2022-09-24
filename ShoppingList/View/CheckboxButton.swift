//
//  CheckboxButton.swift
//  ShoppingList
//
//  Created by Habip Yesilyurt on 24.09.2022.
//

import UIKit

// druuma göre bunu silebilirim
enum CheckBoxState {
    case checked
    case unchecked
}

class CheckboxButton: UIView {
    var isChecked: Bool = false
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.image = UIImage(systemName: "checkmark")
        return imageView
    }()
    
    let boxView: UIView = {
       let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.label.cgColor
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(boxView)
        addSubview(imageView)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        boxView.frame = CGRect(x: 7, y: 7, width: frame.size.width-14, height: frame.size.width-14)
        imageView.frame = bounds
    }
    
    public func toggle() {
        self.isChecked = !isChecked
        imageView.isHidden = !isChecked
    }
    
}
