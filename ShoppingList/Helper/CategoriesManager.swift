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
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        let fetchRequest = NSFetchRequest<Categories>(entityName: "Categories")
        if let parentId = id {
            fetchRequest.predicate = NSPredicate(format: "parentList.id = %@", parentId.uuidString)
        }
        let sortByCreatedAt = NSSortDescriptor(key: "createdAt", ascending: false)
        fetchRequest.sortDescriptors = [sortByCreatedAt]
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
    
    func updateData(id: UUID, updatedText: String?, completion: @escaping (_ isSuccess: Bool, CoreDataError) -> ()) {
        let fetchRequest: NSFetchRequest<Categories> = Categories.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", id.uuidString)
        fetchRequest.returnsObjectsAsFaults = false
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        do {
            let results = try context.fetch(fetchRequest)
            if results.count == 1 {
                let updateCategory = results[0]
                if id == updateCategory.value(forKey: "id") as? UUID {
                    updateCategory.setValue(updatedText, forKey: "name")
                }
                do {
                    try context.save()
                    completion(true, .noError)
                } catch {
                    print("error: \(error.localizedDescription)")
                    completion(false, .savingError)
                }
            }
        } catch {
            print("error: \(error.localizedDescription)")
            completion(false, .fetchingError)
        }
    }
    
    func removeData(id: UUID, completion: @escaping (Bool, CoreDataError) -> ()) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Categories")
        let idString     = id.uuidString
        fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
        fetchRequest.returnsObjectsAsFaults = false
        let request = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(request)
            try context.save()
            completion(true, .noError)
        } catch {
            print("error: \(error.localizedDescription)")
            completion(false, .removingError)
        }
    }
    
}
