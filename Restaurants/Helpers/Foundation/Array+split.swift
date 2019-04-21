//
//  Array+split.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 21/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

extension Array {
    func split(by condition: ((Element) -> Bool)) -> (`true`: [Element], `false`: [Element]) {
        var trueArray = [Element]()
        var falseArray = [Element]()
        self.forEach { item in
            if condition(item) {
                trueArray.append(item)
            } else {
                falseArray.append(item)
            }
        }
        return (true: trueArray, false: falseArray)
    }
}
