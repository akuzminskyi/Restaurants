//
//  RestaurantListViewController.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 20/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

final class RestaurantListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    var presenter: RestaurantListPresenterInterface?
    private var viewModels = [RestaurantViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }
}

extension RestaurantListViewController: RestaurantListViewInterface {
    func show(viewModels: [RestaurantViewModel]) {
        self.viewModels = viewModels
        tableView.reloadData()
    }
}

extension RestaurantListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RestaurantCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupViewModel(viewModels[indexPath.row])
        cell.favouriteButtonAction = {
        }
        return cell
    }
}

private extension RestaurantCell {
    func setupViewModel(_ viewModel: RestaurantViewModel) {
        restaurantTitleLabel.attributedText = viewModel.title
        openingStateLabel.attributedText = viewModel.openingState
        sortValueLabel.attributedText = viewModel.sortValue
        favouriteButtonTitle = viewModel.favoriteMessage
    }
}
