//
//  RestaurantListRouter.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 20/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

enum RestaurantListRouter: RestaurantListRouterInterface {
    private enum Constant {
        static let storyboardName = "RestaurantList"
    }

    static func buildModule() -> UIViewController {
        let interactor = RestaurantListInteractor()

        let storyboard = UIStoryboard(name: Constant.storyboardName, bundle: .main)
        let view: RestaurantListViewController = storyboard.instantiateViewController()
        let presenter = RestaurantListPresenter(
            view: view,
            interactor: interactor
        )

        interactor.presenter = presenter
        view.presenter = presenter

        return view
    }
}
