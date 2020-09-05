//
//  ListContract.swift
//  ExternalApi+Cache
//
//  Created by Ricardo González Pacheco on 04/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol ListRouterProtocol: class {
    func itemSelected(item: ListItemModel)
}

protocol ListPresenterProtocol: class {
    var router: ListRouterProtocol? { get set }
    var view: ListViewProtocol? { get set }
    var interactor: ListInteractorInput? { get set }
    
    // View to Presenter
    func viewIsReady()
    func itemSelected(item: ListItemModel)
}

protocol ListInteractorInput: class {
    var output: ListInteractorOutput? { get set }
    var dataManager: DataManager? { get set }
    
    // Presenter to Interactor
    func executeRequest()
}

protocol ListDataManager: class {
    
    // Interactor to DataManager
    func getItems(completion: @escaping (Result<[ListItemModel], Error>) -> Void)
}

protocol ListInteractorOutput: class {
    
    // Interactor to Presenter
    func executedSuccessfulRequest(items: [ListItemModel])
    func failedRequest(error: Error)
}

protocol ListViewProtocol: class {
    var presenter: ListPresenterProtocol? { get set }
    
    // Presenter to View
    func showItems(items: [ListItemModel])
    func onFetchingDataError(error: Error)
    func showLoading()
    func hideLoading()
}
