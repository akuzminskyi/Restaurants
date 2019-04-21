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
    func like(id: Identifier<Restaurant>) {
        likesStorage.set(true, forKey: id.rawValue)
    }

    func dislike(id: Identifier<Restaurant>) {
        likesStorage.removeObject(forKey: id.rawValue)
    }

    func isLiked(id: Identifier<Restaurant>) -> Bool {
        return likesStorage.bool(forKey: id.rawValue)
    }
}

