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
    private var sortingValues = [SortingValue]()

    @IBOutlet private weak var segmentControl: UISegmentedControl!

    // MARK: - life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }

    // MARK: - IBAction methods

    @IBAction private func segmentControlValuedChanged(_ sender: UISegmentedControl) {
        presenter?.didTap(at: sortingValues[sender.selectedSegmentIndex])
    }
}

extension RestaurantListViewController: RestaurantListViewInterface {
    func showSortingValues(_ sortingValues: [SortingValue], withSelectedIndex index: Int) {
        segmentControl.removeAllSegments()
        sortingValues.enumerated().forEach { (arg) in
            let (index, value) = arg
            segmentControl.insertSegment(withTitle: value.localizedText, at: index, animated: false)
        }
        self.sortingValues = sortingValues
        segmentControl.selectedSegmentIndex = index
    }

    func showSections(_ sections: [RestaurantListSection]) {
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

extension RestaurantListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchTermDidChange(searchText)
    }
}

private extension RestaurantCell {
    func setupViewModel(_ viewModel: RestaurantViewModel) {
        restaurantTitleLabel.attributedText = viewModel.title
        openingStateLabel.attributedText = viewModel.openingState
        sortingValueLabel.attributedText = viewModel.sortingValue
        favouriteButtonTitle = viewModel.favoriteTitle
    }
}

private extension Array where Element == RestaurantListSection {
    subscript(indexPath: IndexPath) -> RestaurantViewModel {
        return self[indexPath.section].viewModels[indexPath.row]
    }
}
