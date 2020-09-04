//
//  DetailRouter.swift
//  ExternalApi+Cache
//
//  Created by Ricardo González Pacheco on 04/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class DetailRouter {
    static func create(withItem item: ListItemModel) -> UIViewController? {
        let presenter = DetailPresenter()
        let view = DetailView()
        
        presenter.view = view
        presenter.item = item
        view.presenter = presenter
        
        return view
    }
}
