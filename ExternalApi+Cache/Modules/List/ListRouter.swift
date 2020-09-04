//
//  ListRouter.swift
//  ExternalApi+Cache
//
//  Created by Ricardo González Pacheco on 04/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

protocol ListDelegate {
    func itemSelected(item: ListItemModel)
}

class ListRouter {
    var delegate: ListDelegate?
    static func create() -> UIViewController? {
        let router = ListRouter()
        let presenter = ListPresenter()
        let interactor = ListInteractor()
        let view = ListView()
        let dataManager = DataManager()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.output = presenter
        interactor.dataManager = dataManager
        
        return view
    }
}

extension ListRouter: ListRouterProtocol {
    func itemSelected(item: ListItemModel) {
        delegate?.itemSelected(item: item)
    }
}
