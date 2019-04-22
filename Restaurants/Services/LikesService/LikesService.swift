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
    func like(_ id: Identifier<Restaurant>) {
        guard !isLiked(id) else {
            return
        }
        likesStorage.set(true, forKey: id.rawValue)
    }

    func dislike(_ id: Identifier<Restaurant>) {
        guard isLiked(id) else {
            return
        }

        likesStorage.removeObject(forKey: id.rawValue)
    }

    func isLiked(_ id: Identifier<Restaurant>) -> Bool {
        return likesStorage.bool(forKey: id.rawValue)
    }
}

