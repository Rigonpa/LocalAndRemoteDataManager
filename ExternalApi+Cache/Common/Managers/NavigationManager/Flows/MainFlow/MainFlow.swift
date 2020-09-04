//
//  MainFlow.swift
//  ExternalApi+Cache
//
//  Created by Ricardo González Pacheco on 03/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class MainFlow: FlowCoordinator {
    var name: String = "MainFlow"
    var flowNavManager: UINavigationController?
    
    func startFlow() -> UINavigationController? {
        guard let listVC = ListRouter.create() as? ListView, let listRouter = listVC.presenter?.router as? ListRouter else { return nil }
        let flowNavManager = UINavigationController(rootViewController: listVC)
        self.flowNavManager = flowNavManager
        
        listRouter.delegate = self
        
        return flowNavManager
    }
}

extension MainFlow: ListDelegate {
    func itemSelected(item: ListItemModel) {
        guard let detailVC = DetailRouter.create(withItem: item) else { return }
        
        flowNavManager?.pushViewController(detailVC, animated: true)
    }
}
