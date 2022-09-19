//
//  ImagesViewController.swift
//  ShoppingList
//
//  Created by habip on 2.09.2022.
//

import UIKit

class ImagesViewController: UIViewController {
    
    private var selectImageView: UIImageView = UIImageView()
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var currentAlert = UIAlertController()
    private lazy var images: [Images] = []
    
    lazy var imagesViewModel = ImagesViewModel(with: self)

    func crateNavigationAddButton() {
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addImageButtonClicked))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Images"
        view.backgroundColor = .white
        crateNavigationAddButton()
        configureCollectionView()
        imagesViewModel.fetcData()
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        setCollectionViewDelegate()
        collectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: ImagesCollectionViewCell.identifier)
        collectionView.frame = view.bounds
        setCollectionViewConstraints()
    }
    
    private func setCollectionViewDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func imagesViewIsLoad() {
        crateNavigationAddButton()
    }
        
    @objc fileprivate func addImageButtonClicked() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds
        blurVisualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let alert = UIAlertController(title: "Select New Image", message: nil, preferredStyle: .alert)
        let imageView = UIImageView(frame: CGRect(x: 10, y: 40, width: 280, height: 220))
        imageView.image = UIImage(systemName: "photo")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
        
        imageView.isUserInteractionEnabled = true
        let imageRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageRecognizer)
        selectImageView = imageView
        currentAlert = alert
        alert.view.addSubview(imageView)
        let height = NSLayoutConstraint(item: alert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        let width = NSLayoutConstraint(item: alert.view!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        alert.view.addConstraint(height)
        alert.view.addConstraint(width)
        let actionButton = UIAlertAction(title: "Save", style: .default) { action in            
            self.imagesViewModel.saveImages(image: imageView.image)
            blurVisualEffectView.removeFromSuperview()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { action in
            blurVisualEffectView.removeFromSuperview()
        }
        alert.addAction(actionButton)
        alert.addAction(cancelButton)
        self.view.addSubview(blurVisualEffectView)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc fileprivate func selectImage() {
        currentAlert.dismiss(animated: true)
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        present(picker, animated: true, completion: nil)
    }

}

extension ImagesViewController: ImagesViewModelDelegate {
    func fetchImages(images: [Images]) {
        self.images = images
        collectionView.reloadData()
    }
    
    func saveImages(images: [Images]) {
        self.images = images
        collectionView.reloadData()
    }
}

extension ImagesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectImageView.contentMode = .scaleAspectFit
        selectImageView.image = info[.originalImage] as? UIImage
        let scaledImage: UIImage = imageValue(with: selectImageView.image!, scaledTo: CGSize(width: selectImageView.frame.width-70, height: selectImageView.frame.height-20))
        selectImageView.image = scaledImage
        self.dismiss(animated: true, completion: nil)
        present(currentAlert, animated: true, completion: nil)
    }
    
    func imageValue(with image: UIImage, scaledTo newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: CGRect(x: 0, y: 15, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? UIImage()
    }
}


extension ImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.identifier, for: indexPath) as? ImagesCollectionViewCell
        guard let cell = cell else{ return UICollectionViewCell() }
        cell.setUp(with: images[indexPath.row])
        return cell
    }
}

extension ImagesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/2)-4, height: (view.frame.size.width/2)-4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
    }
}
