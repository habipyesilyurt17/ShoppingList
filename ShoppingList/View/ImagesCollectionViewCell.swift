//
//  ImagesCollectionViewCell.swift
//  ShoppingList
//
//  Created by Habip Yesilyurt on 19.09.2022.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {
    static let identifier = "ImagesCollectionViewCell"
    private var imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemRed
        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(with image: Images) {
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        if let imageData = image.value(forKey: "image") as? Data {
            let image = UIImage(data: imageData)
            imageView.image = image
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 10, width: contentView.frame.size.width, height: contentView.frame.size.height)
    }
}
