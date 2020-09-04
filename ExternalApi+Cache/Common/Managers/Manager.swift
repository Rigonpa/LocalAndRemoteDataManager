//
//  Manager.swift
//  ExternalApi+Cache
//
//  Created by Ricardo González Pacheco on 03/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

struct Manager {
    
    static var navigation: NavigationManager = {
        let navigationManager = NavigationManager()
        return navigationManager
    }()
    
    static var dataManager: DataManager = {
        let dataManager = DataManager()
        return dataManager
    }()
    
    static func startupManagers(completion: (Bool) -> Void) {
        var allManagersProperlyStarted = true
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        navigation.startup { navigation in
            allManagersProperlyStarted = navigation == nil ? false : true
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        dataManager.startup { dataManager in
            allManagersProperlyStarted = dataManager == nil ? false : true
        }
        
        dispatchGroup.wait()
        completion(allManagersProperlyStarted)
    }
}
