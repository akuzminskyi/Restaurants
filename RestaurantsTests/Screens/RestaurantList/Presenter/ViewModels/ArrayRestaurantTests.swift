//
//  ArrayRestaurantTests.swift
//  RestaurantsTests
//
//  Created by Andrii Kuzminskyi on 22/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import XCTest
@testable import Restaurants

final class ArrayRestaurantTests: XCTestCase {

    // MARK: - sorted

    func test_GivenUnsortedByStatusArray_WhenSorted_ThenRestaurantsSortedByStatus() {
        let array = [
            Restaurant(name: "A", status: .orderAhead, sortingValues: sortingValues()),
            Restaurant(name: "B", status: .orderAhead, sortingValues: sortingValues()),
            Restaurant(name: "C", status: .closed, sortingValues: sortingValues()),
            Restaurant(name: "D", status: .open, sortingValues: sortingValues()),
            Restaurant(name: "E", status: .closed, sortingValues: sortingValues()),
            Restaurant(name: "F", status: .orderAhead, sortingValues: sortingValues())
        ]

        let expectedResult: [Restaurant.OpeningsState] = [.open, .orderAhead, .orderAhead, .orderAhead, .closed, .closed]
        XCTAssertEqual(array.sorted(by: .bestMatch).map({ $0.status }), expectedResult)
    }

    func test_GivenTheSameStatus_AndSortingValues_WhenSortedByBestMatch_ThenRestaurantsSortedByBestMatchValue() {
        let array = [
            Restaurant(name: "A", status: .open, sortingValues: sortingValues(bestMatch: 0.7)),
            Restaurant(name: "B", status: .open, sortingValues: sortingValues(bestMatch: 1.03)),
            Restaurant(name: "C", status: .open, sortingValues: sortingValues(bestMatch: 0.23)),
        ]
        XCTAssertEqual(array.sorted(by: .bestMatch).map { $0.sortingValues.bestMatch }, [1.03, 0.7, 0.23])
    }

    func test_GivenTheDifferentStatus_AndSortingValues_WhenSortedByBestMatch_ThenRestaurantsSortedByStatusAndBestMatchValue() {
        let array = [
            Restaurant(name: "A", status: .open, sortingValues: sortingValues(bestMatch: 0.23)),
            Restaurant(name: "B", status: .closed, sortingValues: sortingValues(bestMatch: 0.7)),
            Restaurant(name: "C", status: .open, sortingValues: sortingValues(bestMatch: 0.5)),
            Restaurant(name: "D", status: .orderAhead, sortingValues: sortingValues(bestMatch: 0.5)),
            Restaurant(name: "E", status: .orderAhead, sortingValues: sortingValues(bestMatch: 1.03)),
        ]

        XCTAssertEqual(array.sorted(by: .bestMatch).map { $0.name }, ["C", "A", "E", "D", "B"])
    }

    func test_GivenTheSameStatus_AndSortingValues_WhenSorted_ThenRestaurantsSortedByName() {
        let array = [
            Restaurant(name: "B", status: .open, sortingValues: sortingValues(bestMatch: 1.0)),
            Restaurant(name: "A", status: .open, sortingValues: sortingValues(bestMatch: 1.0)),
            Restaurant(name: "C", status: .open, sortingValues: sortingValues(bestMatch: 1.0)),
        ]

        XCTAssertEqual(array.sorted(by: .bestMatch).map { $0.name }, ["A", "B", "C"])
    }


    // MARK: - mocks

    private func sortingValues(bestMatch: Double = 0.0) -> Restaurant.SortingValues {
        return Restaurant.SortingValues(
            bestMatch: bestMatch,
            newest: 0,
            ratingAverage: 0,
            distance: 0,
            popularity: 0,
            averageProductPrice: 0,
            deliveryCosts: 0,
            minCost: 0
        )
    }
}
