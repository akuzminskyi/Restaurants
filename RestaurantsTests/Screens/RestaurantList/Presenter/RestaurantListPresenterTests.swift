//
//  RestaurantListPresenterTests.swift
//  RestaurantsTests
//
//  Created by Andrii Kuzminskyi on 22/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import XCTest
@testable import Restaurants
final class RestaurantListPresenterTests: XCTestCase {
    private var presenter: RestaurantListPresenter!
    private var mockedView: MockRestaurantListView!
    private var mockedInteractor: MockRestaurantListInteractor!
    private var mockedRouter: MockRestaurantListRouter!
    private var mockedViewModelBuilder: MockRestaurantListViewModelBuilder!

    override func setUp() {
        super.setUp()
        mockedView = MockRestaurantListView()
        mockedInteractor = MockRestaurantListInteractor()
        mockedRouter = MockRestaurantListRouter()
        mockedViewModelBuilder = MockRestaurantListViewModelBuilder()

        presenter = RestaurantListPresenter(
            view: mockedView,
            interactor: mockedInteractor,
            router: mockedRouter,
            viewModelBuilder: mockedViewModelBuilder
        )
    }

    override func tearDown() {
        presenter = nil
        mockedView = nil
        mockedInteractor = nil
        mockedRouter = nil
        mockedViewModelBuilder = nil
        super.tearDown()
    }

    // MARK: - onViewDidLoad

    func test_WhenOnViewDidLoad_ThenInteractorFetchRestaurantsCalledOnce() {
        presenter.onViewDidLoad()

        XCTAssertEqual(mockedInteractor.spyFetchRestaurantsCallCount, 1)
    }

    func test_WhenOnViewDidLoad_ThenViewShowsSortingValues() {
        presenter.onViewDidLoad()

        let expectedResult: [SortingValue] = [
                .bestMatch,
                .newest,
                .ratingAverage,
                .distance,
                .popularity,
                .averageProductPrice,
                .deliveryCosts,
                .minCost
        ]
        XCTAssertEqual(mockedView.spyShowSortingValues.map { $0.sortingValues }, [expectedResult])
    }

    func test_WhenOnViewDidLoad_ThenSelectedIndexIs0() {
        presenter.onViewDidLoad()

        XCTAssertEqual(mockedView.spyShowSortingValues.map { $0.selectedIndex }, [0])
    }

    // MARK: - successfullyFetched

    func test_WhenSuccessfullyFetched_ThenViewReceivedViewModelsFromBuilder() {
        presenter.successfullyFetched(restaurants: [])

        XCTAssertEqual(mockedView.showSections, [mockedViewModelBuilder.stubViewModels])
    }

    func test_GivenStubbedRestaurants_WhenSuccessfullyFetched_ThenViewModelBuilderReceivedSections() {
        presenter.successfullyFetched(restaurants: [stubbedRestaurant()])

        XCTAssertEqual(mockedViewModelBuilder.spyViewModels.map { $0.restaurants }, [[stubbedRestaurant()]])
    }

    // MARK: - failureFetchedRestaurants

    func test_WhenFailureFetchedRestaurants_ThenRouterShowErrorScreen() {
        presenter.failureFetchedRestaurants(with: NSError(domain: "fake", code: 0, userInfo: [NSLocalizedDescriptionKey: "fake text"]))

        XCTAssertEqual(mockedRouter.spyRouteToErrorScreen, ["fake text"])
    }

    // MARK: - didTap(at sortingValue: SortingValue)

    func test_GivenNewest_WhenDidTapAtSortingValue_ThenViewModelBuilderHasNewestSortingValue() {
        presenter.didTap(at: .newest)

        XCTAssertEqual(mockedViewModelBuilder.spyViewModels.map { $0.sortingValue }, [.newest])
    }

    func test_GivenNewest_WhenDidTapAtSortingValue_ThenViewReceivedViewModelsFromBuilder() {
        presenter.didTap(at: .newest)

        XCTAssertEqual(mockedView.showSections, [mockedViewModelBuilder.stubViewModels])
    }

    // MARK: - didTap(at viewModel: RestaurantViewModel

    func test_WhenDidTapAtViewModel_ThenInteractorToggleLike() {
        presenter.didTap(at: stubbedRestaurantViewModel())

        XCTAssertEqual(mockedInteractor.spyToggleLike, [Identifier<Restaurant>(rawValue: "fake")])
    }

    func test_WhenDidTapAtViewModel_ThenViewReceivedViewModelsFromBuilder() {
        presenter.didTap(at: stubbedRestaurantViewModel())

        XCTAssertEqual(mockedView.showSections, [mockedViewModelBuilder.stubViewModels])
    }

    // MARK: - searchTermDidChange

    func test_WhenSearchTermDidChange_ThenViewModelBuilderHasSearchTerm() {
        presenter.searchTermDidChange("fake")

        XCTAssertEqual(mockedViewModelBuilder.spyViewModels.map { $0.searchTerm }, ["fake"])
    }

    func test_WhenSearchTermDidChange_ThenViewReceivedViewModelsFromBuilder() {
        presenter.didTap(at: stubbedRestaurantViewModel())

        XCTAssertEqual(mockedView.showSections, [mockedViewModelBuilder.stubViewModels])
    }

    // MARK: - helpers

    private func stubbedRestaurant() -> Restaurant {
        return Restaurant(name: "fake", status: .open, sortingValues: sortingValues())
    }

    private func sortingValues() -> Restaurant.SortingValues {
        return Restaurant.SortingValues(
            bestMatch: 0.0,
            newest: 0,
            ratingAverage: 0,
            distance: 0,
            popularity: 0,
            averageProductPrice: 0,
            deliveryCosts: 0,
            minCost: 0
        )
    }

    private func stubbedRestaurantViewModel() -> RestaurantViewModel {
        return RestaurantViewModel(
            title: NSAttributedString(string: "fake"),
            openingState: NSAttributedString(string: "fake"),
            sortingValue: NSAttributedString(string: "fake"),
            favoriteTitle: "fake",
            id: Identifier<Restaurant>(rawValue: "fake")
        )
    }
}

