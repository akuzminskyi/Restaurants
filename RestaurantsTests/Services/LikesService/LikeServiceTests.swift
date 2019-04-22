//
//  LikeServiceTests.swift
//  RestaurantsTests
//
//  Created by Andrii Kuzminskyi on 22/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import XCTest
@testable import Restaurants

final class LikeServiceTests: XCTestCase {
    private var service: LikesService!
    private var mockedStorage: MockStorage!
    private let stubbedIdentifier = Identifier<Restaurant>(rawValue: "stubbedId")

    override func setUp() {
        super.setUp()
        mockedStorage = MockStorage()
        service = LikesService(storage: mockedStorage)
    }

    override func tearDown() {
        mockedStorage = nil
        service = nil
        super.tearDown()
    }

    // MARK: - like

    func test_GivenGetValueAsFalse_WhenLike_ThenStorageSetValueForKey() {
        mockedStorage.stubBoolValue = false
        service.like(stubbedIdentifier)

        XCTAssertEqual(mockedStorage.spySetValue, [["stubbedId": true]])
    }

    func test_GivenGetValueAsTrue_WhenLike_ThenSetValueDoesNotCall() {
        mockedStorage.stubBoolValue = true
        service.like(stubbedIdentifier)

        XCTAssertTrue(mockedStorage.spySetValue.isEmpty)
    }

    func test_GivenToggedBoolValue_WhenLikeTwice_ThenStorageSetValueForKeyOnce() {
        mockedStorage.stubBoolValue = false
        service.like(stubbedIdentifier)
        mockedStorage.stubBoolValue = true
        service.like(stubbedIdentifier)

        XCTAssertEqual(mockedStorage.spySetValue, [["stubbedId": true]])
    }

    // MARK: - dislike

    func test_GivenGetValueAsTrue_WhenDislike_ThenStorageRemoveObject() {
        mockedStorage.stubBoolValue = true
        service.dislike(stubbedIdentifier)

        XCTAssertEqual(mockedStorage.spyRemoveObject, ["stubbedId"])
    }

    func test_GivenGetValueAsFalse_WhenDislikeTwice_ThenStorageRemoveDoesNotCall() {
        mockedStorage.stubBoolValue = false
        service.dislike(stubbedIdentifier)

        XCTAssertTrue(mockedStorage.spyRemoveObject.isEmpty)
    }

    func test_GivenToggedBoolValue_WhenDislikeTwice_ThenStorageRemoveObjectOnce() {
        mockedStorage.stubBoolValue = false
        service.dislike(stubbedIdentifier)
        mockedStorage.stubBoolValue = true
        service.dislike(stubbedIdentifier)

        XCTAssertEqual(mockedStorage.spyRemoveObject, ["stubbedId"])
    }

    // MARK: - isLiked

    func test_GivenGetBoolValueAsFalse_WhenIsLiked_ThenReturnsFalse() {
        mockedStorage.stubBoolValue = false

        XCTAssertFalse(service.isLiked(stubbedIdentifier))
    }

    func test_GivenGetBoolValueAsTrue_WhenIsLiked_ThenReturnsFalse() {
        mockedStorage.stubBoolValue = true

        XCTAssertTrue(service.isLiked(stubbedIdentifier))
    }

}

