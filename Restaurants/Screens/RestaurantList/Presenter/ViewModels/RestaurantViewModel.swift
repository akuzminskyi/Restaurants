//
//  RestaurantViewModel.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 20/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

struct RestaurantViewModel {
    let title: NSAttributedString
    let openingState: NSAttributedString
    let sortingValue: NSAttributedString
    let favoriteTitle: String
    let id: Identifier<Restaurant>
}

extension RestaurantViewModel {
    static func == (lhs: RestaurantViewModel, rhs: Restaurant) -> Bool {
        return lhs.id == rhs.id
    }
}
