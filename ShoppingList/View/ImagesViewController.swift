//
//  ImagesViewController.swift
//  ShoppingList
//
//  Created by habip on 2.09.2022.
//

import UIKit

class ImagesViewController: UIViewController {
    
    private var selectImageView: UIImageView = UIImageView()
    var currentAlert = UIAlertController()
    
    func crateNavigationAddButton() {
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addImageButtonClicked))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Images"
        view.backgroundColor = .white
        crateNavigationAddButton()
    }
    
    func imagesViewIsLoad() {
        crateNavigationAddButton()
    }
        
    @objc fileprivate func addImageButtonClicked() {
        let alert = UIAlertController(title: "Select New Image", message: nil, preferredStyle: .alert)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 40, width: 300, height: 250))
        imageView.image = UIImage(systemName: "photo")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
        
        imageView.isUserInteractionEnabled = true
        let imageRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageRecognizer)
        selectImageView = imageView
        currentAlert = alert
        
        alert.view.addSubview(imageView)
        
        let height = NSLayoutConstraint(item: alert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 330)
        let width = NSLayoutConstraint(item: alert.view!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        alert.view.addConstraint(height)
        alert.view.addConstraint(width)
        let actionButton = UIAlertAction(title: "Save", style: .default) { action in
            // send data to viewModel
            print("action")
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actionButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc fileprivate func selectImage() {
        currentAlert.dismiss(animated: true)
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        //picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }

}

extension ImagesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectImageView.contentMode = .scaleAspectFit
        selectImageView.image = info[.originalImage] as? UIImage
        
        self.dismiss(animated: true, completion: nil)
        present(currentAlert, animated: true, completion: nil)
    }
}
