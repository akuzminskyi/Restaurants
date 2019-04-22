//
//  Restaurant.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 16/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

struct Restaurant: Decodable, Identifiable {
    enum OpeningsState: String, Decodable, CaseIterable {
        case open
        case orderAhead = "order ahead"
        case closed
    }

    struct SortingValues: Decodable {
        let bestMatch: Double
        let newest: Double
        let ratingAverage: Double
        let distance: Double
        let popularity: Double
        let averageProductPrice: Double
        let deliveryCosts: Double
        let minCost: Double
    }

    let name: String
    let status: OpeningsState
    let sortingValues: SortingValues
    let id: Identifier<Restaurant>

    private enum CodingKeys: String, CodingKey {
        case name
        case status
        case sortingValues
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(OpeningsState.self, forKey: .status)
        sortingValues = try container.decode(SortingValues.self, forKey: .sortingValues)
        id = Identifier<Restaurant>(rawValue: name)
    }
}
