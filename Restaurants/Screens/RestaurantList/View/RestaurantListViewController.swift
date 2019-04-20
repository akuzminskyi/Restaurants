//
//  RestaurantListViewController.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 20/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

final class RestaurantListViewController: UIViewController {
    var presenter: RestaurantListPresenterInterface?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }
}

extension RestaurantListViewController: RestaurantListViewInterface {

}
