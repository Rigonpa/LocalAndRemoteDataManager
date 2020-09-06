//
//  DataManagerTet.swift
//  ExternalApi+CacheTests
//
//  Created by Ricardo González Pacheco on 06/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation
import XCTest
import CoreData

@testable import ExternalApi_Cache
class DataManagerTest: XCTestCase {
    
    /* Cases I am going to test:
     1. Local has no data saved (1st time) && Remote failed -> completion(.failed(error)) (Network error)
     2. Local has no data saved (1st time) && Remote succeed -> completion(.succeed(list)) - EXPECTED case for 1st time
     3. Local request failed && Remote failed -> completion(.failed(errorLocal + errorRemote ¿?¿?)) - Strange case
     4. Local request failed && Remote succeed -> completion(.succeed(list) + .failed(localError) ¿?¿?) - Strange case
     5. Local has data saved -> completion(.succeed(list)) - EXPECTED case
     */
    
    /*
     UPDATE. By using pattern Result in parameters of data manager functions I can only pass succeed result or failed one, but never both.
     This affects next way to some of the above 5 cases:
     3. -> completion(.failed(errorRemote))
     4. -> completion(.succeed(list))
     */
    
    var mockInteractor: MockInteractor!
    
    var mockEmptyLocalDataManager: MockEmptyLocalDataManager!
    var mockSuccessLocalDataManager: MockSuccessLocalDataManager!
    var mockFailureLocalDataManager: MockFailureLocalDataManager!
    var mockSuccessRemoteDataManager: MockSuccessRemoteDataManager!
    var mockFailureRemoteDataManager: MockFailureRemoteDataManager!
    
    override func setUp() {
        mockInteractor = MockInteractor()
        mockInteractor.testingDataManager = DataManager()
        
        mockEmptyLocalDataManager = MockEmptyLocalDataManager()
        mockSuccessLocalDataManager = MockSuccessLocalDataManager()
        mockFailureLocalDataManager = MockFailureLocalDataManager()
        mockSuccessRemoteDataManager = MockSuccessRemoteDataManager()
        mockFailureRemoteDataManager = MockFailureRemoteDataManager()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    func test1_fetchData_noLocalAndFailedRemoteRequest_shouldReturnNetworkError() {
        mockInteractor.testingDataManager?.localDataManager = mockEmptyLocalDataManager
        mockInteractor.testingDataManager?.remoteDataManager = mockFailureRemoteDataManager
        
        mockInteractor.executeRequest()
        
        XCTAssertTrue(mockInteractor.failedFetchRequest)
        XCTAssertEqual(mockInteractor.items.count, 0)
    }
    
    func test2_fetchData_noLocalAndSucceedRemoteRequest_shouldReturnList() {
        mockInteractor.testingDataManager?.localDataManager = mockEmptyLocalDataManager
        mockInteractor.testingDataManager?.remoteDataManager = mockSuccessRemoteDataManager
        
        mockInteractor.executeRequest()
        
        XCTAssertTrue(mockInteractor.succeedFetchRequest)
        XCTAssertEqual(mockInteractor.items.count, 2)
    }
    
    func test3_fetchData_failedLocalRequestAndfailedRemoteRequest_shouldReturnLocalAndRemoteErrors() {
        mockInteractor.testingDataManager?.localDataManager = mockFailureLocalDataManager
        mockInteractor.testingDataManager?.remoteDataManager = mockFailureRemoteDataManager
        
        mockInteractor.executeRequest()
        
        XCTAssertTrue(mockInteractor.failedFetchRequest)
        XCTAssertEqual(mockInteractor.items.count, 0)
    }
    
    func test4_fetchData_failedLocalRequestAndSucceedRemoteRequest_shouldReturnListAndLocalError() {
        mockInteractor.testingDataManager?.localDataManager = mockFailureLocalDataManager
        mockInteractor.testingDataManager?.remoteDataManager = mockSuccessRemoteDataManager
        
        mockInteractor.executeRequest()
        
        XCTAssertTrue(mockInteractor.succeedFetchRequest)
        XCTAssertEqual(mockInteractor.items.count, 2)
    }
    
    func test5_fetchData_succeedLocalRequest_shouldReturnList() {
        mockInteractor.testingDataManager?.localDataManager = mockSuccessLocalDataManager
        mockInteractor.testingDataManager?.remoteDataManager = mockSuccessRemoteDataManager // It is not relevant
        
        mockInteractor.executeRequest()
        
        XCTAssertTrue(mockInteractor.succeedFetchRequest)
        XCTAssertEqual(mockInteractor.items.count, 2)
        
    }
}

class MockInteractor: ListInteractorInput {
    var succeedFetchRequest = false
    var items = [ListItemModel]()
    var failedFetchRequest = false
    
    typealias MockDataManagerProtocols = ListDataManager & DataManagerProtocol
    
    var output: ListInteractorOutput?
    var dataManager: ListDataManager?
    
    var testingDataManager: MockDataManagerProtocols?
    
    func executeRequest() {
        testingDataManager?.getItems(completion: {[weak self] result in
            switch result {
            case .failure(_ ):
                self?.failedFetchRequest = true
                self?.items = []
            case .success(let list):
                self?.succeedFetchRequest = true
                self?.items = list
            }
        })
    }
}

class MockEmptyLocalDataManager: LocalDataManagerProtocol {
    func getItems(completion: (Result<[Item], Error>) -> Void) {
        completion(.success([]))
    }
    
    func persistItems(items: [ListItemModel]) throws {
        
    }
}

class MockSuccessLocalDataManager: LocalDataManagerProtocol {
    var context: NSManagedObjectContext? {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.persistentContainer.viewContext
    }
    
    func getItems(completion: (Result<[Item], Error>) -> Void) {
        guard let moc = context,
            let entity = NSEntityDescription.entity(forEntityName: "Item", in: moc) else { return }
        let item1 = Item(entity: entity, insertInto: context)
        item1.id = 3
        item1.title = "Title3"
        item1.imageUrl = "www.marcogol.com"
        
        let item2 = Item(entity: entity, insertInto: context)
        item2.id = 4
        item2.title = "Title4"
        item2.imageUrl = "www.lampara.com"
        
        completion(.success([item1, item2]))
    }
    
    func persistItems(items: [ListItemModel]) throws {
        
    }
}

class MockFailureLocalDataManager: LocalDataManagerProtocol {
    func getItems(completion: (Result<[Item], Error>) -> Void) {
        completion(.failure(NSError()))
    }
    
    func persistItems(items: [ListItemModel]) throws {
        
    }
}

class MockSuccessRemoteDataManager: RemoteDataManagerProtocol {
    func downloadItems(completion: @escaping (Result<[ListItemModel], Error>) -> Void) {
        let list = [
            ListItemModel(id: 3, title: "Title3", imageUrl: "www.marcogol.com"),
            ListItemModel(id: 4, title: "Title4", imageUrl: "www.lampara.com")
        ]
        completion(.success(list))
    }
}

class MockFailureRemoteDataManager: RemoteDataManagerProtocol {
    func downloadItems(completion: @escaping (Result<[ListItemModel], Error>) -> Void) {
        completion(.failure(NSError()))
    }
}
