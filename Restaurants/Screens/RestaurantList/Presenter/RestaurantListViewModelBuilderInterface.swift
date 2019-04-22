//
//  RestaurantListViewModelBuilderInterface.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 20/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol RestaurantListViewModelBuilderInterface {
    func viewModels(
        from restaurants: [Restaurant],
        sortedBy sortingValue: SortingValue,
        filteredByName searchTerm: String?
    ) -> [RestaurantListSection]
}
