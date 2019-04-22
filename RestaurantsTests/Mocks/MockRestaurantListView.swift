//
//  MockRestaurantListView.swift
//  RestaurantsTests
//
//  Created by Andrii Kuzminskyi on 22/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation
@testable import Restaurants

final class MockRestaurantListView: RestaurantListViewInterface {
    private(set) var spyShowSortingValues = [(sortingValues: [SortingValue], selectedIndex: Int)]()
    private(set) var showSections = [[RestaurantListSection]]()

    func showSortingValues(_ sortingValues: [SortingValue], withSelectedIndex index: Int) {
        spyShowSortingValues.append((sortingValues, index))
    }

    func showSections(_ sections: [RestaurantListSection]) {
        showSections.append(sections)
    }
}
