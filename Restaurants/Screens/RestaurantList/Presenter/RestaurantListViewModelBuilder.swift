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

    private func sectionViewModel(
        from restaurants: [Restaurant],
        asLiked isLiked: Bool,
        withTitle title: String,
        highlightedText: String?
    ) -> RestaurantListSection? {
        guard !restaurants.isEmpty else {
            return nil
        }

        let viewModels = restaurants.compactMap { restaurant -> RestaurantViewModel? in
            guard let titleAttributedString = try? self.titleAttributedString(
                title: restaurant.name,
                highlightedText: highlightedText
            ) else {
                return nil
            }
            return RestaurantViewModel(
                title: titleAttributedString,
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

    private func titleAttributedString(title: String, highlightedText: String?) throws -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: title)
        guard let highlightedText = highlightedText, !highlightedText.isEmpty else {
            return (attributedString.copy() as! NSAttributedString)
        }
        let regex = try NSRegularExpression(pattern: highlightedText, options: .caseInsensitive)
        let range = NSRange(location: 0, length: title.utf16.count)
        for match in regex.matches(in: title, options: .withTransparentBounds, range: range) {
            attributedString.addAttribute(
                    .font,
                value: UIFont.boldSystemFont(ofSize: 18),
                range: match.range
            )
        }
        return attributedString
    }
}

extension RestaurantListViewModelBuilder: RestaurantListViewModelBuilderInterface {
    func viewModels(from restaurants: [Restaurant], filteredByName searchTerm: String?) -> [RestaurantListSection] {
        let filteredRestaurants: [Restaurant]

        if let searchTerm = searchTerm, !searchTerm.isEmpty {
            filteredRestaurants = restaurants.filter { restaurant -> Bool in
                return restaurant.name.localizedCaseInsensitiveContains(searchTerm)
            }
        } else {
            filteredRestaurants = restaurants
        }

        let (likedRestaurants, dislikeRestaurants) = filteredRestaurants
            .sorted()
            .split { restaurant -> Bool in
                return likesService.isLiked(restaurant.id)
        }

        return [
            sectionViewModel(
                from: likedRestaurants,
                asLiked: true,
                withTitle: "RestaurantList_Section_Liked".localized(),
                highlightedText: searchTerm
            ),
            sectionViewModel(
                from: dislikeRestaurants,
                asLiked: false,
                withTitle: "RestaurantList_Section_AllRestaurants".localized(),
                highlightedText: searchTerm
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
