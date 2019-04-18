//
//  RestaurantListService.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 18/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

struct RestaurantListService: RestaurantListServiceInterface {
    private let dataProviderService: DataProviderServiceInterface
    private let jsonDecoder: JSONDecoder

    init(dataProviderService: DataProviderServiceInterface, jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.dataProviderService = dataProviderService
        self.jsonDecoder = jsonDecoder
    }

    func fetchRestaurantList(completion: ((Result<RestaurantList, Error>) -> Void)) {
        do {
            let data = try dataProviderService.data(fromAsset: "restaurwants.json")
            let list = try jsonDecoder.decode(RestaurantList.self, from: data)
            completion(.success(list))
        } catch let error {
            completion(.failure(error))
        }
    }
}
