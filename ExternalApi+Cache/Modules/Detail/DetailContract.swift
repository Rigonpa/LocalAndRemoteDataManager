//
//  DetailContract.swift
//  ExternalApi+Cache
//
//  Created by Ricardo González Pacheco on 04/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol DetailPresenterProtocol: class {
    var item: ListItemModel? { get set }
    var view: DetailViewProtocol? { get set }
    // View to presenter
    func viewIsReady()
}

protocol DetailViewProtocol: class {
    var presenter: DetailPresenterProtocol? { get set }
    
    // Presenter to view
    func showItemDetails(item: ListItemModel?)
}
