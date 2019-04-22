//
//  RestaurantListPresenter.swift
//  Restaurants
//
//  Created by Andrii Kuzminskyi on 20/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

final class RestaurantListPresenter {
    private struct InputAttibutes {
        var searchTerm: String?
        var restaurants: [Restaurant]?
        var sortingValue: SortingValue = .bestMatch
    }

    private weak var view: RestaurantListViewInterface?
    private let interactor: RestaurantListInteractorInterface
    private let router: RestaurantListRouterInterface
    private let viewModelBuilder: RestaurantListViewModelBuilderInterface
    private var attributes = InputAttibutes()

    init(
        view: RestaurantListViewInterface,
        interactor: RestaurantListInteractorInterface,
        router: RestaurantListRouterInterface,
        viewModelBuilder: RestaurantListViewModelBuilderInterface
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.viewModelBuilder = viewModelBuilder
    }

    // MARK: - private methods

    private func presentRestaurants(with attributes: InputAttibutes) {
        let sections = viewModelBuilder.viewModels(
            from: attributes.restaurants ?? [],
            sortedBy: attributes.sortingValue,
            filteredByName: attributes.searchTerm
        )
        view?.showSections(sections)
    }

    private func presentActualRestaurantList() {
        presentRestaurants(with: attributes)
    }

    private func setupSortingValues() {
        let sortingValues = SortingValue.allCases
        let selectedIndex = sortingValues.firstIndex(of: attributes.sortingValue) ?? 0
        view?.showSortingValues(sortingValues, withSelectedIndex: selectedIndex)
    }
}

extension RestaurantListPresenter: RestaurantListPresenterInterface {
    func onViewDidLoad() {
        setupSortingValues()
        interactor.fetchRestaurants()
    }

    func didTap(at sortingValue: SortingValue) {
        attributes.sortingValue = sortingValue
        presentActualRestaurantList()
    }

    func didTap(at viewModel: RestaurantViewModel) {
        interactor.toggleLike(for: viewModel.id)
        presentActualRestaurantList()
    }

    func searchTermDidChange(_ text: String) {
        attributes.searchTerm = text
        presentActualRestaurantList()
    }

    func successfullyFetched(restaurants: [Restaurant]) {
        attributes.restaurants = restaurants
        presentActualRestaurantList()
    }

    func failureFetchedRestaurants(with error: Error) {
        attributes.restaurants = nil
        presentActualRestaurantList()
        router.routeToErrorScreen(withMessage: error.localizedDescription)
    }
}
