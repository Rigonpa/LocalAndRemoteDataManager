//
//  DetailPresenter.swift
//  ExternalApi+Cache
//
//  Created by Ricardo González Pacheco on 04/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

class DetailPresenter {
    
    var item: ListItemModel?
    weak var view: DetailViewProtocol?
}

extension DetailPresenter: DetailPresenterProtocol {
    func viewIsReady() {
        view?.showItemDetails(item: item)
    }
}
