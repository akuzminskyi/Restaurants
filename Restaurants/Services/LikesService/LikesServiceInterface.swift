//
//  LikesServiceInteface.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 21/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol LikesServiceReadOnlyInterface {
    func isLiked(_ id: Identifier<Restaurant>) -> Bool
}

protocol LikesServiceInterface: LikesServiceReadOnlyInterface {
    func like(_ id: Identifier<Restaurant>)
    func dislike(_ id: Identifier<Restaurant>)
}
