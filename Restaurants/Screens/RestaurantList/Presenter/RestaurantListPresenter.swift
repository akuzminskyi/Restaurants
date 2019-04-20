//
//  RestaurantListPresenter.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 20/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

final class RestaurantListPresenter {
    private weak var view: RestaurantListViewInterface?
    private let interactor: RestaurantListInteractorInterface
    private let router: RestaurantListRouterInterface
    private let viewModelBuilder: RestaurantListViewModelBuilderInterface

    init(
        view: RestaurantListViewInterface,
        interactor: RestaurantListInteractorInterface,
        router: RestaurantListRouterInterface,
        viewModelBuilder: RestaurantListViewModelBuilderInterface
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.viewModelBuilder = viewModelBuilder
    }
}

extension RestaurantListPresenter: RestaurantListPresenterInterface {
    func successfullyFetched(restaurants: [Restaurant]) {

    }

    func failureFetchedRestaurants(with error: Error) {
        router.routeToErrorScreen(withMessage: error.localizedDescription)
    }

    func onViewDidLoad() {
        interactor.fetchRestaurants()
    }
}
