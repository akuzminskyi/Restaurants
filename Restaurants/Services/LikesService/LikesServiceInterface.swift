//
//  LikesServiceInteface.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 21/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol LikesServiceInterface {
    func like(restaurant: Restaurant)
    func dislike(restaurant: Restaurant)
    func isLiked(restaurant: Restaurant) -> Bool
}
