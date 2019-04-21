//
//  Identifier.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 21/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

struct Identifier<T: Equatable>: Equatable {
    private let value: T

    init(value: T) {
        self.value = value
    }
}
