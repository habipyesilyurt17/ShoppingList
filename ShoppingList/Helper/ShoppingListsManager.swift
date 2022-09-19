//
//  ShoppingListsManager.swift
//  ShoppingList
//
//  Created by habip on 4.09.2022.
//

import UIKit
import CoreData

final class ShoppingListsManager: CoraDataManagerDelegate {
    static let shared = ShoppingListsManager()
    typealias T = ShoppingLists

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func saveData(data: ShoppingLists, completion: @escaping (_ isSuccess: Bool, CoreDataError)->()) {
        do {
            try self.context.save()
        
            completion(true, .noError)
        } catch {
            print("error: \(error.localizedDescription)")
            completion(false, .savingError)
        }
    }
    
    func fetchData(completion: @escaping (Result<[ShoppingLists], CoreDataError>) -> ()) {
        let fetchRequest = NSFetchRequest<ShoppingLists>(entityName: "ShoppingLists")
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
    
    func removeData(id: UUID, completion: @escaping (_ isSuccess: Bool, CoreDataError) -> ()) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ShoppingLists")
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
