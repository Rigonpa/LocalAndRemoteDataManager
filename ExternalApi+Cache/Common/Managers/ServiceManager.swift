//
//  ServiceManager.swift
//  ExternalApi+Cache
//
//  Created by Ricardo González Pacheco on 03/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol ServiceManager {
    var name: String { get set }
    func startup(completion: (ServiceManager?) -> Void)
}
