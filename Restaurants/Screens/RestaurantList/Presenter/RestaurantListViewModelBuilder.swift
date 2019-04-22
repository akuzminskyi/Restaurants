//
//  RestaurantListViewModelBuilder.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 20/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

struct RestaurantListViewModelBuilder {
    private let likesService: LikesServiceReadOnlyInterface

    init(likesService: LikesServiceReadOnlyInterface) {
        self.likesService = likesService
    }

    // MARK: - private methods

    private func sectionViewModel(from restaurants: [Restaurant], asLiked isLiked: Bool, withTitle title: String) -> RestaurantListSection? {
        guard !restaurants.isEmpty else {
            return nil
        }

        let viewModels = restaurants.map { restaurant -> RestaurantViewModel in
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
                favoriteTitle: isLiked ? "❤️" : "💔",
                id: restaurant.id
            )
        }
        return RestaurantListSection(title: title, viewModels: viewModels)
    }
}

extension RestaurantListViewModelBuilder: RestaurantListViewModelBuilderInterface {
    func viewModels(from restaurants: [Restaurant]) -> [RestaurantListSection] {
        let (likedRestaurants, dislikeRestaurants) = restaurants.sorted().split { restaurant -> Bool in
            return likesService.isLiked(restaurant.id)
        }
        return [
            sectionViewModel(
                from: likedRestaurants,
                asLiked: true,
                withTitle: "RestaurantList_Section_Liked".localized()),
            sectionViewModel(
                from: dislikeRestaurants,
                asLiked: false,
                withTitle: "RestaurantList_Section_AllRestaurants".localized()
            )
        ].compactMap { $0 }
    }
}

private extension Array where Element == Restaurant {
    func sorted() -> [Element] {
        let indexableStatuses = Restaurant.OpeningsState.indexableAllCases
        return sorted { (lhs, rhs) -> Bool in
            guard let leftIndex = indexableStatuses[lhs.status], let rightIndex = indexableStatuses[rhs.status] else {
                fatalError("This never happens")
            }
            guard leftIndex == rightIndex else {
                return leftIndex < rightIndex
            }
            return lhs.name.caseInsensitiveCompare(rhs.name) == .orderedAscending
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
