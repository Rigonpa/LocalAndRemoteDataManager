//
//  ListInteractor.swift
//  ExternalApi+Cache
//
//  Created by Ricardo González Pacheco on 04/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

class ListInteractor {
    
    weak var output: ListInteractorOutput?
    var dataManager: DataManager?
}

extension ListInteractor: ListInteractorInput {
    
    func executeRequest() {
        dataManager?.getItems(completion: { result in
            switch result {
            case .failure(let error):
                output?.failedRequest()
            case .success(let list):
                output?.executedSuccessfulRequest(items: list)
            }
        })
    }
}
