//
//  ListInteractor.swift
//  ExternalApi+Cache
//
//  Created by Ricardo González Pacheco on 04/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

final class ListInteractor {
    
    weak var output: ListInteractorOutput?
    var dataManager: ListDataManager?
}

extension ListInteractor: ListInteractorInput {
    
    func executeRequest() {
        dataManager?.getItems(completion: {[weak self] result in
            switch result {
            case .failure(let error):
                self?.output?.failedRequest(error: error)
            case .success(let list):
                self?.output?.executedSuccessfulRequest(items: list)
            }
        })
    }
}
