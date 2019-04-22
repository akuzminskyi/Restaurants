//
//  MockRestaurantListViewModelBuilder.swift
//  RestaurantsTests
//
//  Created by Andrii Kuzminskyi on 22/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation
@testable import Restaurants

final class MockRestaurantListViewModelBuilder: RestaurantListViewModelBuilderInterface {
    private(set) var spyViewModels = [(restaurants: [Restaurant], sortingValue: SortingValue, searchTerm: String?)]()
    var stubViewModels = [RestaurantListSection(title: "fake", viewModels: [])]

    func viewModels(from restaurants: [Restaurant], sortedBy sortingValue: SortingValue, filteredByName searchTerm: String?) -> [RestaurantListSection] {
        spyViewModels.append((restaurants, sortingValue, searchTerm))
        return stubViewModels
    }
}

