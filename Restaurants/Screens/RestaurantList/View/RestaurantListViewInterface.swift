//
//  RestaurantListViewInterface.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 20/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol RestaurantListViewInterface: AnyObject {
    func showSortingValues(_ sortingValues: [SortingValue], withSelectedIndex index: Int)
    func showSections(_ sections: [RestaurantListSection])
}
