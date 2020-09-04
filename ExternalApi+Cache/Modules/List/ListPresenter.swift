//
//  ListPresenter.swift
//  ExternalApi+Cache
//
//  Created by Ricardo González Pacheco on 04/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

class ListPresenter {
    
    var router: ListRouterProtocol?
    weak var view: ListViewProtocol?
    var interactor: ListInteractorInput?
    
}

// From ListView
extension ListPresenter: ListPresenterProtocol {
    func itemSelected(item: ListItemModel) {
        router?.itemSelected(item: item)
    }
    
    func viewIsReady() {
        interactor?.executeRequest()
    }
}

// From ListIteractor
extension ListPresenter: ListInteractorOutput {
    func executedSuccessfulRequest(items: [ListItemModel]) {
        view?.showItems(items: items)
    }
    
    func failedRequest() {
        view?.onFetchingDataError()
    }
}
