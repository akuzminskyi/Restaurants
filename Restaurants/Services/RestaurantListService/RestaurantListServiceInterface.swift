//
//  RestaurantsProviderServiceInterface.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 16/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol RestaurantsProviderServiceInterface {
    func fetchRestaurantList(completion: ((Result<RestaurantList, Error>) -> Void))
}

extension RestaurantsProviderServiceInterface {
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
