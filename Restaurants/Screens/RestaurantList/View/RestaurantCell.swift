//
//  RestaurantCell.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 20/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

final class RestaurantCell: UITableViewCell {
    @IBOutlet private(set) weak var restaurantTitleLabel: UILabel!
    @IBOutlet private(set) weak var openingStateLabel: UILabel!
    @IBOutlet private(set) weak var sortingValueLabel: UILabel!
    @IBOutlet private weak var favouriteButton: UIButton!

    var favouriteButtonTitle: String? {
        set {
            favouriteButton.setTitle(newValue, for: .normal)
        }
        get {
            return favouriteButton.title(for: .normal)
        }
    }

    var favouriteButtonAction: (() -> Void)?

    // MARK: - overriden methods

    override func awakeFromNib() {
        super.awakeFromNib()
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
    }

    // MARK: - private methods

    @objc private func favouriteButtonTapped() {
        favouriteButtonAction?()
    }
}
