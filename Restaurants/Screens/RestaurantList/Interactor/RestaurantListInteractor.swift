//
//  RestaurantListInteractor.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 20/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

final class RestaurantListInteractor {
    private let restaurantListService: RestaurantListServiceInterface
    weak var presenter: RestaurantListPresenterInterface?

    init(restaurantListService: RestaurantListServiceInterface) {
        self.restaurantListService = restaurantListService
    }
}

extension RestaurantListInteractor: RestaurantListInteractorInterface {
    func fetchRestaurants() {
        restaurantListService.fetchRestaurants { result in
            switch result {
            case let .success(restaurants):
                presenter?.successfullyFetched(restaurants: restaurants)
            case let .failure(error):
                presenter?.failureFetchedRestaurants(with: error)
            }
        }
    }
}
