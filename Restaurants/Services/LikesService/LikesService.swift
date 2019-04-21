//
//  LikeService.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 21/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

final class LikesService {
    private let likesStorage: Storable

    init(storage: Storable) {
        likesStorage = storage
    }
}

extension LikesService: LikesServiceInterface {
    func like(restaurant: Restaurant) {
        likesStorage.set(true, forKey: restaurant.identifier.value)
    }

    func dislike(restaurant: Restaurant) {
        likesStorage.removeObject(forKey: restaurant.identifier.value)
    }

    func isLiked(restaurant: Restaurant) -> Bool {
        return likesStorage.bool(forKey: restaurant.identifier.value)
    }

}

