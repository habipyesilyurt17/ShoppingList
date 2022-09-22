//
//  UIImage+Ext.swift
//  ShoppingList
//
//  Created by Habip Yesilyurt on 22.09.2022.
//

import UIKit

extension UIImage {
    func colored(in color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            color.set()
            self.withRenderingMode(.alwaysTemplate).draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
