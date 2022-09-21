//
//  ImagesViewModelDelegate.swift
//  ShoppingList
//
//  Created by Habip Yesilyurt on 19.09.2022.
//

import Foundation

protocol ImagesViewModelDelegate {
    func saveImages(images: [Images])
    func fetchImages(images: [Images])
    func removeFromImages(images: [Images])
}
