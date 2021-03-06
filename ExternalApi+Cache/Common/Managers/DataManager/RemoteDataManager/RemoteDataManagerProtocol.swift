//
//  RemoteDataManagerProtocol.swift
//  ExternalApi+Cache
//
//  Created by Ricardo González Pacheco on 03/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol RemoteDataManagerProtocol {
    func downloadItems(completion: @escaping (Result<[ListItemModel], Error>) -> Void)
}
