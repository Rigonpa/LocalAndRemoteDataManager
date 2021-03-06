//
//  DataManager.swift
//  ExternalApi+Cache
//
//  Created by Ricardo González Pacheco on 03/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

class DataManager: ServiceManager {
    var name: String = "DataManager"
    
    var coreDataManager: CoreDataManagerProtocol? = CoreDataManager()
    var realmDataManager: RealmDataManagerProtocol? = RealmDataManager() // Future usage
    var firebaseDataManager: FirebaseDataManagerProtocol? = FirebaseDataManager() // Future usage
    var remoteDataManager: RemoteDataManagerProtocol? = RemoteDataManager()

    /* Change done for being able to test data manager (DataMangerTest.test)
    lazy var localDataManager: LocalDataManagerProtocol = {
        let ldm = LocalDataManager()
        return ldm
    }()

    lazy var remoteDataManager: RemoteDataManagerProtocol = {
        let rdm = RemoteDataManager()
        return rdm
    }()
     */
 
    
    func startup(completion: (ServiceManager?) -> Void) {
        completion(self)
    }
}

extension DataManager: DataManagerProtocol {
    
}

extension DataManager: ListDataManager {
    func getItems(completion: @escaping (Result<[ListItemModel], Error>) -> Void) {
        // First check if it is locally saved the list:
        coreDataManager?.getItems { resultCoreData in
            switch resultCoreData {
                /* I do not know how core data behaves when the desired array of NSManagedObject is null,
                 if it throws an error or just empty array []
                 That is the reason why I call two times function itemsAreNotLocallySaved:
                */
            case .failure(_): // Error from localDataManager actions ***********
                itemsAreNotLocallySaved(completion: completion)
            case .success(let coreDataList):
                if !coreDataList.isEmpty {
                    let list = coreDataList.map { ListItemModel(id: Int($0.id), title: $0.title!, imageUrl: $0.imageUrl!)}
                    completion(.success(list))
                } else {
                    itemsAreNotLocallySaved(completion: completion)
                }
            }
        }
    }
    
    private func itemsAreNotLocallySaved(completion: @escaping (Result<[ListItemModel], Error>) -> Void) {
        // Then (list has not been saved previously in core data) ask for it through external api
        remoteDataManager?.downloadItems {[weak self] resultExternalApi in
            switch resultExternalApi {
            case .failure(let error):
                completion(.failure(error)) // Error from remoteDataManager actions ***********
            case .success(let list):
                self?.saveItemsInCoreData(list: list)
                completion(.success(list))
            }
        }
    }
    
    private func saveItemsInCoreData(list: [ListItemModel]) {
        try? coreDataManager?.persistItems(items: list)
    }
}
