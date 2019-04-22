//
//  MockRestaurantListInteractor.swift
//  RestaurantsTests
//
//  Created by Andrii Kuzminskyi on 22/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation
@testable import Restaurants

final class MockRestaurantListInteractor: RestaurantListInteractorInterface {
    private(set) var spyToggleLike = [Identifier<Restaurant>]()
    private(set) var spyFetchRestaurantsCallCount = 0

    func toggleLike(for id: Identifier<Restaurant>) {
        spyToggleLike.append(id)
    }

    func fetchRestaurants() {
        spyFetchRestaurantsCallCount += 1
    }
}
