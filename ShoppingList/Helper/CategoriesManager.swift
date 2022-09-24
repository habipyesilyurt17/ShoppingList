//
//  CategoriesManager.swift
//  ShoppingList
//
//  Created by habip on 4.09.2022.
//

import UIKit
import CoreData


final class CategoriesManager: CoreDataManagerDelegate {
    static let shared = CategoriesManager()
    typealias T = Categories
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveData(data: Categories, completion: @escaping (Bool, CoreDataError) -> ()) {
        do {
            try self.context.save()
            completion(true, .noError)
        } catch {
            print("error: \(error.localizedDescription)")
            completion(false, .savingError)
        }
    }

    func fetchData(id: UUID?, completion: @escaping (Result<[Categories], CoreDataError>) -> ()) {
        let fetchRequest = NSFetchRequest<Categories>(entityName: "Categories")
        if let id = id {
            fetchRequest.predicate = NSPredicate(format: "parentList.id = %@", id.uuidString)
        }
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                completion(.success(results))
            }
        } catch {
            print("error: \(error.localizedDescription)")
            completion(.failure(.fetchingError))
        }
    }
    
    func removeData(id: UUID, completion: @escaping (Bool, CoreDataError) -> ()) {
        
    }
    
}
