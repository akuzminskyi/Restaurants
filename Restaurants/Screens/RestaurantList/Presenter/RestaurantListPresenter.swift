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
    private let viewModelBuilder: RestaurantListViewModelBuilderInterface

    init(
        view: RestaurantListViewInterface,
        interactor: RestaurantListInteractorInterface,
        viewModelBuilder: RestaurantListViewModelBuilderInterface
    ) {
        self.view = view
        self.interactor = interactor
        self.viewModelBuilder = viewModelBuilder
    }
}

extension RestaurantListPresenter: RestaurantListPresenterInterface {
    func successfullyFetched(restaurants: [Restaurant]) {

    }

    func failureFetchedRestaurants(with error: Error) {
        // handle it somehow, alert?
    }

    func onViewDidLoad() {
        interactor.fetchRestaurants()
    }
}
