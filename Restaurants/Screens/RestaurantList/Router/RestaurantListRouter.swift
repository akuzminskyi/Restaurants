//
//  RestaurantListRouter.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 20/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

final class RestaurantListRouter {
    private enum Constant {
        static let storyboardName = "RestaurantList"
    }

    private weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }
}

extension RestaurantListRouter: RestaurantListRouterInterface {
    static func buildModule() -> UIViewController {
        let dataProvider = DataProviderService()
        let restaurantListService = RestaurantListService(dataProviderService: dataProvider)
        let interactor = RestaurantListInteractor(restaurantListService: restaurantListService)

        let storyboard = UIStoryboard(name: Constant.storyboardName, bundle: .main)
        let view: RestaurantListViewController = storyboard.instantiateViewController()
        let router = RestaurantListRouter(view: view)
        let viewModelBuilder = RestaurantListViewModelBuilder()

        let presenter = RestaurantListPresenter(
            view: view,
            interactor: interactor,
            router: router,
            viewModelBuilder: viewModelBuilder
        )

        interactor.presenter = presenter
        view.presenter = presenter

        return view
    }

    func routeToErrorScreen(withMessage message: String) {
        let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "RestaurantList_Error_OK".localized(), style: .default) { _ in }
        alertViewController.addAction(action)
        view?.present(alertViewController, animated: true, completion: nil)
    }
}
