//
//  NavigationManager.swift
//  ExternalApi+Cache
//
//  Created by Ricardo González Pacheco on 03/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class NavigationManager: ServiceManager {
    var name: String = "NavigationManager"
    
    var rootNavBar: UINavigationController?
    var rootFlow: FlowCoordinator?
    
    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    
    func startup(completion: (ServiceManager?) -> Void) {
        completion(self)
    }
    
    func startApp() {
        let mainFlow = MainFlow()
        let navigationController = mainFlow.startFlow()
        rootFlow = mainFlow
        rootNavBar = navigationController
        
        sceneDelegate?.window?.rootViewController = navigationController
        sceneDelegate?.window?.makeKeyAndVisible()        
    }
}
