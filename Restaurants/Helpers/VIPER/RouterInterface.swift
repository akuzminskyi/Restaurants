//
//  RouterInterface.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 20/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

protocol RouterInterface {
    static func buildModule() -> UIViewController
}

extension RouterInterface {
    @discardableResult
    static func buildModule(into navigationController: UINavigationController) -> UIViewController {
        let viewController = buildModule()
        navigationController.pushViewController(viewController, animated: true)
        return viewController
    }
}
