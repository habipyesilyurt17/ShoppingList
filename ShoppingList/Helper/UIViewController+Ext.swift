//
//  UIViewController+Ext.swift
//  ShoppingList
//
//  Created by habip on 4.09.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func alertWithTextField(with title: String,
                            _ message: String,
                            _ actionButtonTitle: String,
                            _ cancelButtonTitle: String,
                            _ placeholder: String,
                            completion: @escaping (String)->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = placeholder
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
