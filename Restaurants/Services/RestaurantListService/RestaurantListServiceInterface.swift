//
//  RestaurantListServiceInterface.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 16/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol RestaurantListServiceInterface {
    func fetchRestaurantList(completion: ((Result<RestaurantList, Error>) -> Void))
}

extension RestaurantListServiceInterface {
    func fetchRestaurants(completion: ((Result<[Restaurant], Error>) -> Void)) {
        fetchRestaurantList { result in
            switch result {
            case let .success(restaurantList):
                completion(.success(restaurantList.restaurants))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
