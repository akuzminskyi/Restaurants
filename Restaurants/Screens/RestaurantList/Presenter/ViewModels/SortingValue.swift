//
//  SortingValue.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 22/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

enum SortingValue: CaseIterable {
    case bestMatch
    case newest
    case ratingAverage
    case distance
    case popularity
    case averageProductPrice
    case deliveryCosts
    case minCost

    var localizedText: String {
        switch self {
        case .bestMatch: return "SortingValue_BestMatch".localized()
        case .newest: return "SortingValue_Newest".localized()
        case .ratingAverage: return "SortingValue_AverageRating".localized()
        case .distance: return "SortingValue_Distance".localized()
        case .popularity: return "SortingValue_Popularity".localized()
        case .averageProductPrice: return "SortingValue_AveragePrice".localized()
        case .deliveryCosts: return "SortingValue_DeliveryCosts".localized()
        case .minCost: return "SortingValue_MinimumCost".localized()
        }
    }
}
