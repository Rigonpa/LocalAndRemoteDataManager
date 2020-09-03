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
        return UINavigationController()
    }
}
