//
//  RestaurantListInteractor.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 20/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

final class RestaurantListInteractor {
    weak var presenter: RestaurantListPresenterInterface?
}

extension RestaurantListInteractor: RestaurantListInteractorInterface {

}