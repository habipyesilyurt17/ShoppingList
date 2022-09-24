//
//  ImagesViewModel.swift
//  ShoppingList
//
//  Created by Habip Yesilyurt on 19.09.2022.
//

import Foundation
import UIKit

final class ImagesViewModel {
    private var imagesViewModelDelegate: ImagesViewModelDelegate?
    
    init(with imagesViewModelDelegate: ImagesViewModelDelegate) {
        self.imagesViewModelDelegate = imagesViewModelDelegate
    }
    
    var images: [Images] = []
    
    func saveImages(image: UIImage?) {
        let newImage = Images(context: ImagesManager.shared.context)
        if let image = image {
            let imageData = image.jpegData(compressionQuality: 0.5)
            newImage.id    = UUID()
            newImage.image = imageData
        }
        
        ImagesManager.shared.saveData(data: newImage) { isSucess, saveError in
            if isSucess {
                self.images.append(newImage)
                self.imagesViewModelDelegate?.saveImages(images: self.images)
            } else {
                print("error: \(saveError)")
            }
        }
    }
    
    
    func fetcData() {
        ImagesManager.shared.fetchData(id: nil) { response in
            switch response {
            case .success(let images):
                self.images = images
                self.imagesViewModelDelegate?.fetchImages(images: self.images)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func removeImage(imageId: UUID?, index: Int) {
        if let imageId = imageId {
            ImagesManager.shared.removeData(id: imageId) { isSuccess, deleteError in
                if isSuccess {
                    self.images.remove(at: index)
                    self.imagesViewModelDelegate?.removeFromImages(images: self.images)
                } else {
                    print("error: \(deleteError)")
                }
            }
        }
    }
}
