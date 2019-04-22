//
//  Array+Restaurant.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 22/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

extension Array where Element == Restaurant {
    func sorted(by sortValue: SortingValue) -> [Element] {
        let indexableStatuses = Restaurant.OpeningsState.indexableAllCases
        return sorted { (lhs, rhs) -> Bool in
            guard let leftIndex = indexableStatuses[lhs.status], let rightIndex = indexableStatuses[rhs.status] else {
                fatalError("This never happens")
            }
            guard leftIndex == rightIndex else {
                return leftIndex < rightIndex
            }

            guard lhs.sortingValues[sortValue] == rhs.sortingValues[sortValue] else {
                return lhs.sortingValues[sortValue] > rhs.sortingValues[sortValue]
            }

            return lhs.name.caseInsensitiveCompare(rhs.name) == .orderedAscending
        }
    }
}

extension Restaurant.SortingValues {
    subscript(sortingValue: SortingValue) -> Double {
        switch sortingValue {
        case .bestMatch: return bestMatch
        case .newest: return newest
        case .ratingAverage: return ratingAverage
        case .distance: return distance
        case .popularity: return popularity
        case .averageProductPrice: return averageProductPrice
        case .deliveryCosts: return deliveryCosts
        case .minCost: return minCost
        }
    }
}
