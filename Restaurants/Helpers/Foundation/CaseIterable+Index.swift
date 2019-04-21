//
//  CaseIterable+Index.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 21/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

extension CaseIterable where Self: Hashable {
    static var indexableAllCases: [Self.AllCases.Element: Int] {
        return allCases.enumerated().reduce(into: [Self.AllCases.Element: Int]()) { (result, arg1) in
            let (offset, element) = arg1
            result[element] = offset
        }
    }
}
