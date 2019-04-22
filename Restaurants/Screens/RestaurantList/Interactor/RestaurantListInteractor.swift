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
    private let likesService: LikesServiceInterface
    weak var presenter: RestaurantListPresenterInterface?

    init(restaurantListService: RestaurantListServiceInterface, likesService: LikesServiceInterface) {
        self.restaurantListService = restaurantListService
        self.likesService = likesService
    }
}

extension RestaurantListInteractor: RestaurantListInteractorInterface {
    func toggleLike(for id: Identifier<Restaurant>) {
        if likesService.isLiked(id) {
            likesService.dislike(id)
        } else {
            likesService.like(id)
        }
    }

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
