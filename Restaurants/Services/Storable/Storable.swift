//
//  Storable.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 21/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol Storable {
    func set(_ value: Bool, forKey defaultName: String)
    func removeObject(forKey defaultName: String)
    func bool(forKey defaultName: String) -> Bool
}

extension UserDefaults: Storable { }
