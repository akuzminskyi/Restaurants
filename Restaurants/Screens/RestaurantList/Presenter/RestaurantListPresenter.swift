//
//  RestaurantListPresenter.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 20/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

final class RestaurantListPresenter {
    private weak var view: RestaurantListViewInterface?
    private let interactor: RestaurantListInteractorInterface

    init(
        view: RestaurantListViewInterface,
        interactor: RestaurantListInteractorInterface
    ) {
        self.view = view
        self.interactor = interactor
    }
}

extension RestaurantListPresenter: RestaurantListPresenterInterface {

}
