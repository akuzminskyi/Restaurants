//
//  RestaurantListPresenterInterface.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 20/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol RestaurantListPresenterInterface: AnyObject {
    func onViewDidLoad()

    func didTap(at viewModel: RestaurantViewModel)
    func didTap(at sortingValue: SortingValue)
    func searchTermDidChange(_ text: String)

    func successfullyFetched(restaurants: [Restaurant])
    func failureFetchedRestaurants(with error: Error)
}
