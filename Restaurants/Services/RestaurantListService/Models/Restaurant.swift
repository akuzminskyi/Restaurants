//
//  Restaurant.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 16/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

struct Restaurant: Decodable {
    enum OpeningsState: String, Decodable {
        case open
        case orderAhead = "order ahead"
        case closed
    }

    struct SortingValues: Decodable {
        let bestMatch: Float
        let newest: Float
        let ratingAverage: Float
        let distance: Float
        let popularity: Float
        let averageProductPrice: Decimal
        let deliveryCosts: Decimal
        let minCost: Decimal
    }

    let name: String
    let status: OpeningsState
    let sortringValues: SortingValues
}