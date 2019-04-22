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

    private func present(restaurants: [Restaurant]?) {
        let sections = viewModelBuilder.viewModels(from: restaurants ?? [])
        view?.show(sections: sections)
    }
}

extension RestaurantListPresenter: RestaurantListPresenterInterface {
    func didTap(at viewModel: RestaurantViewModel) {
        interactor.toggleLike(for: viewModel.id)
        present(restaurants: receivedRestaurants)
    }

    func successfullyFetched(restaurants: [Restaurant]) {
        receivedRestaurants = restaurants
        present(restaurants: receivedRestaurants)
    }

    func failureFetchedRestaurants(with error: Error) {
        receivedRestaurants = nil
        present(restaurants: receivedRestaurants)
        router.routeToErrorScreen(withMessage: error.localizedDescription)
    }

    func onViewDidLoad() {
        interactor.fetchRestaurants()
    }
}
