//
//  DataManagerProtocol.swift
//  ExternalApi+Cache
//
//  Created by Ricardo González Pacheco on 06/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol DataManagerProtocol {
    var localDataManager: LocalDataManagerProtocol? { get set }
    var remoteDataManager: RemoteDataManagerProtocol? { get set }
}
