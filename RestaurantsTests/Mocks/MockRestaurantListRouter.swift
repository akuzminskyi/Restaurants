//
//  MockRestaurantListRouter.swift
//  RestaurantsTests
//
//  Created by Andrii Kuzminskyi on 22/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit
@testable import Restaurants

final class MockRestaurantListRouter: RestaurantListRouterInterface {
    static var stubbedBuildModule = UIViewController()
    private(set) var spyRouteToErrorScreen = [String]()

    static func buildModule() -> UIViewController {
        return stubbedBuildModule
    }

    func routeToErrorScreen(withMessage message: String) {
        spyRouteToErrorScreen.append(message)
    }
}

