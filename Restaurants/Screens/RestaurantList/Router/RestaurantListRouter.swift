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
        let dataProvider = DataProviderService()
        let restaurantListService = RestaurantListService(dataProviderService: dataProvider)
        let interactor = RestaurantListInteractor(restaurantListService: restaurantListService)

        let storyboard = UIStoryboard(name: Constant.storyboardName, bundle: .main)
        let view: RestaurantListViewController = storyboard.instantiateViewController()
        let viewModelBuilder = RestaurantListViewModelBuilder()
        
        let presenter = RestaurantListPresenter(
            view: view,
            interactor: interactor,
            viewModelBuilder: viewModelBuilder
        )

        interactor.presenter = presenter
        view.presenter = presenter

        return view
    }
}
