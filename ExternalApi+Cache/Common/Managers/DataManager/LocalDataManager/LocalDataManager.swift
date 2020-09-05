//
//  LocalDataManager.swift
//  ExternalApi+Cache
//
//  Created by Ricardo González Pacheco on 03/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit
import CoreData

enum PersistenceError: Error {
    case managedObjectContextNotFound
    case couldNotSaveObject
    case objectNotFound
}

class LocalDataManager: LocalDataManagerProtocol {
    lazy var context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError()}
        return appDelegate.persistentContainer.viewContext
    }()
    
    func persistItems(items: [ListItemModel]) throws {
        if let entity = NSEntityDescription.entity(forEntityName: String(describing: Item.self), in: context) {
            _ = items.map {
                let item = Item(entity: entity, insertInto: context)
                item.id = Int32($0.id)
                item.title = $0.title
                item.imageUrl = $0.imageUrl
            }
            try context.save()
        }
        throw PersistenceError.couldNotSaveObject
    }
    
    func getItems(completion: (Result<[Item], Error>) -> Void) {
        
        let request = NSFetchRequest<Item>(entityName: String(describing: Item.self))
        
        do {
            var list = try context.fetch(request)
            list.sort(by: { $0.id < $1.id})
            completion(.success(list))
            // Qué pasa si no hay ningún error de código, pero el array de items está vacío en core data
            // debería devolver completion(.success([])) pero no ningún error. ¿?¿?
        } catch let error {
            completion(.failure(error))
        }
        
    }
}
