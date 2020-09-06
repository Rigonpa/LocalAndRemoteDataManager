//
//  ExternalApi_CacheTests.swift
//  ExternalApi+CacheTests
//
//  Created by Ricardo González Pacheco on 03/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import XCTest
@testable import ExternalApi_Cache

class InteractorTest: XCTestCase {
    
    var testingInteractor: ListInteractor!
    // Router would:
    var mockPresenter: MockPresenter!
    var mockErrorDataManager: MockErrorDataManager!
    var mockSuccessDataManager: MockSuccessDataManager!

    override func setUpWithError() throws {
        try? super.setUpWithError()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testingInteractor = ListInteractor()
        mockPresenter = MockPresenter()
        mockErrorDataManager = MockErrorDataManager()
        mockSuccessDataManager = MockSuccessDataManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try? super.tearDownWithError()
    }
    
    func test_fetchData_successProcess_shouldReturnList() {
        // Supposed
        testingInteractor.output = mockPresenter
        testingInteractor.dataManager = mockSuccessDataManager
        
        // When
        testingInteractor.executeRequest()
        
        // Then
        guard let presenter = mockPresenter else { return }
        XCTAssertTrue(presenter.succeededFetchInteractorProcess)
        XCTAssertEqual(presenter.items.count, 2)
        
        
    }
    
    func test_fetchData_failedProcess_shouldReturnError() {
        testingInteractor.output = mockPresenter
        testingInteractor.dataManager = mockErrorDataManager
        
        testingInteractor.executeRequest()
        
        guard let presenter = mockPresenter else { return }
        XCTAssertTrue(presenter.failedFetchInteractorProcess)
        XCTAssertEqual(presenter.items.count, 0)
    }

}

class MockPresenter: ListInteractorOutput {
    var succeededFetchInteractorProcess = false
    var items: [ListItemModel] = []
    var failedFetchInteractorProcess = false
    
    func executedSuccessfulRequest(items: [ListItemModel]) {
        succeededFetchInteractorProcess = true
        self.items = items
    }
    
    func failedRequest(error: Error) {
        failedFetchInteractorProcess = true
        self.items = []
    }
}

class MockErrorDataManager: ListDataManager {
    func getItems(completion: @escaping (Result<[ListItemModel], Error>) -> Void) {
        completion(.failure(NSError()))
    }
}

class MockSuccessDataManager: ListDataManager {
    func getItems(completion: @escaping (Result<[ListItemModel], Error>) -> Void) {
        let list = [
            ListItemModel(id: 3, title: "Title3", imageUrl: "www.marcogol.com"),
            ListItemModel(id: 4, title: "Title4", imageUrl: "www.lampara.com")
        ]
        completion(.success(list))
    }
}
