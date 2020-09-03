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
    
    func startup(completion: (ServiceManager?) -> Void) {
        completion(self)
    }
}
