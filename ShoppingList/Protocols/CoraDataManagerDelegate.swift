//
//  CoraDataManagerDelegate.swift
//  ShoppingList
//
//  Created by habip on 4.09.2022.
//

import Foundation

enum CoreDataError: String, Error {
    case savingError   = "Data couldn't be saved"
    case removingError = "Data couldn't be removed"
    case fetchingError = "Data couldn't be fetched"
    case checkingError = "Data couldn't be checked"
    case noError
}

protocol CoraDataManagerDelegate {
    associatedtype T
    func saveData(data: T, completion: @escaping (_ isSuccess: Bool, CoreDataError)->())
    func fetchData(completion: @escaping (Result<[T], CoreDataError>)->())
    func removeData(id: UUID, completion: @escaping (_ isSuccess: Bool, CoreDataError)->())
    // buraya update de gelebilir
}
