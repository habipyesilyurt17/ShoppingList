//
//  UIViewController+Ext.swift
//  ShoppingList
//
//  Created by habip on 4.09.2022.
//

import UIKit

extension UIViewController {
    func alertWithTextField(with title: String,
                            _ message: String,
                            _ actionButtonTitle: String,
                            _ cancelButtonTitle: String,
                            _ placeholder: String?,
                            _ currentText: String?,
                            completion: @escaping (String)->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { textField in
            if let placeholder = placeholder {
                textField.placeholder = placeholder
            }
            if let currentText = currentText {
                textField.text = currentText
            }
        }
        let actionButton = UIAlertAction(title: actionButtonTitle, style: .default) { action in
            completion(alert.textFields?[0].text ?? "")
        }
        let cancelButton = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil)
        alert.addAction(actionButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
}
