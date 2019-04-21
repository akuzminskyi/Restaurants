//
//  Identifier.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 21/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol Identifiable {
    associatedtype RawIdentifier: Codable & Equatable = String

    var id: Identifier<Self> { get }
}

struct Identifier<Value: Identifiable>: Equatable {
    let rawValue: Value.RawIdentifier

    init(rawValue: Value.RawIdentifier) {
        self.rawValue = rawValue
    }
}
