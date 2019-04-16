//
//  RestaurantList.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 16/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

struct RestaurantList: Decodable {
    let restaurants: [Restaurant]
}
