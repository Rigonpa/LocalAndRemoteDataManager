//
//  FlowCoordinator.swift
//  ExternalApi+Cache
//
//  Created by Ricardo González Pacheco on 03/09/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

protocol FlowCoordinator {
    var name: String { get }
    var flowNavManager: UINavigationController? { get set }
    func startFlow() -> UINavigationController?
}
