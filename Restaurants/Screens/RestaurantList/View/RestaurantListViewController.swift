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
    private var sections = [RestaurantListSection]()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }
}

extension RestaurantListViewController: RestaurantListViewInterface {
    func show(sections: [RestaurantListSection]) {
        self.sections = sections
        tableView.reloadData()
    }
}

extension RestaurantListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].viewModels.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RestaurantCell = tableView.dequeueReusableCell(for: indexPath)
        let viewModel = sections[indexPath]
        cell.setupViewModel(viewModel)
        cell.favouriteButtonAction = { [weak self] in
            guard let self = self else {
                return
            }
            self.presenter?.didTap(at: viewModel)
        }
        return cell
    }
}

private extension RestaurantCell {
    func setupViewModel(_ viewModel: RestaurantViewModel) {
        restaurantTitleLabel.attributedText = viewModel.title
        openingStateLabel.attributedText = viewModel.openingState
        sortValueLabel.attributedText = viewModel.sortValue
        favouriteButtonTitle = viewModel.favoriteTitle
    }
}

private extension Array where Element == RestaurantListSection {
    subscript(indexPath: IndexPath) -> RestaurantViewModel {
        return self[indexPath.section].viewModels[indexPath.row]
    }
}
