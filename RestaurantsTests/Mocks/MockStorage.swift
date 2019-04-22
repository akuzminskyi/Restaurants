//
//  MockStorage.swift
//  RestaurantsTests
//
//  Created by Andrii Kuzminskyi on 22/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation
@testable import Restaurants

final class MockStorage: Storable {
    private(set) var spySetValue = [[String: Bool]]()
    private(set) var spyRemoveObject = [String]()
    var stubBoolValue: Bool = true

    func set(_ value: Bool, forKey defaultName: String) {
        spySetValue.append([defaultName: value])
    }

    func removeObject(forKey defaultName: String) {
        spyRemoveObject.append(defaultName)
    }

    func bool(forKey defaultName: String) -> Bool {
        return stubBoolValue
    }
}
