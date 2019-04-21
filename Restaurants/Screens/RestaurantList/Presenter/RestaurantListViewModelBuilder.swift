//
//  RestaurantListViewModelBuilder.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 20/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

struct RestaurantListViewModelBuilder {
    private let likesService: LikesServiceInterface

    init(likesService: LikesServiceInterface) {
        self.likesService = likesService
    }
}

extension RestaurantListViewModelBuilder: RestaurantListViewModelBuilderInterface {
    func viewModels(from restaurants: [Restaurant]) -> [RestaurantViewModel] {
        return restaurants.map { restaurant -> RestaurantViewModel in
            return RestaurantViewModel(
                title: NSAttributedString(string: restaurant.name),
                openingState: NSAttributedString(
                    string: restaurant.status.localized,
                    attributes: [
                            .foregroundColor: UIColor.darkGray,
                            .font: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
                    ]
                ),
                sortValue: NSAttributedString(
                    string: "",
                    attributes: [
                            .foregroundColor: UIColor.darkGray,
                            .font: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
                    ]),
                favoriteTitle: likesService.isLiked(id: restaurant.id) ? "❤️" : "💔",
                id: restaurant.id
            )
        }
    }
}

private extension Restaurant.OpeningsState {
    var localized: String {
        switch self {
        case .closed:
            return "OpeningsState_Closed".localized()
        case .open:
            return "OpeningsState_Open".localized()
        case .orderAhead:
            return "OpeningsState_OrderAhead".localized()
        }
    }
}
