//
//  RemoteDataManager.swift
//  ExternalApi+Cache
//
//  Created by Ricardo González Pacheco on 03/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class RemoteDataManager: RemoteDataManagerProtocol {
    func downloadItems(completion: @escaping (Result<[ListItemModel], Error>) -> Void) {
        guard let url = URL(string: "https://fierce-cove-29863.herokuapp.com/getAllPosts") else { return }
        AF.request(url).validate().responseArray { (response: AFDataResponse<[ListItemModel]>) in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let list):
                completion(.success(list))
            }
        }
    }
}
