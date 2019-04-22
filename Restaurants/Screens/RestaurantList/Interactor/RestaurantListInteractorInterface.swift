//
//  RestaurantListInteractorInterface.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 20/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol RestaurantListInteractorInterface {
    func toggleLike(for id: Identifier<Restaurant>)
    func fetchRestaurants()
}
