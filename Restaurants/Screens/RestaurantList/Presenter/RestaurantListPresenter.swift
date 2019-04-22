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
    private let router: RestaurantListRouterInterface
    private let viewModelBuilder: RestaurantListViewModelBuilderInterface
    private var receivedRestaurants: [Restaurant]?
    private var searchTerm: String?

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

    private func presentRestaurants(_ restaurants: [Restaurant], filteredByName filteredName: String?) {
        let sections = viewModelBuilder.viewModels(from: restaurants, filteredByName: filteredName)
        view?.show(sections: sections)
    }

    private func presentActualRestaurantList() {
        presentRestaurants(receivedRestaurants ?? [], filteredByName: searchTerm)
    }
}

extension RestaurantListPresenter: RestaurantListPresenterInterface {
    func onViewDidLoad() {
        interactor.fetchRestaurants()
    }

    func didTap(at viewModel: RestaurantViewModel) {
        interactor.toggleLike(for: viewModel.id)
        presentActualRestaurantList()
    }

    func searchTermDidChange(_ text: String) {
        searchTerm = text
        presentActualRestaurantList()
    }

    func successfullyFetched(restaurants: [Restaurant]) {
        receivedRestaurants = restaurants
        presentActualRestaurantList()
    }

    func failureFetchedRestaurants(with error: Error) {
        receivedRestaurants = nil
        presentActualRestaurantList()
        router.routeToErrorScreen(withMessage: error.localizedDescription)
    }
}
