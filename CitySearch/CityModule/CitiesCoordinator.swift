//
//  CitiesCoordinator.swift
//  CitySearch
//
//  Created by Husein Huseinau on 18.03.2023.
//

import UIKit

final class CityCoordinator {

    // MARK: Private Variables

    private let navigationController: UINavigationController

    // MARK: Lifecycle

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigateToCityList()
    }

    // MARK: Custom Accessors

    private func navigateToCityList() {
        let (cityListViewController, cityListViewModel) = CitiesListBuilder.build()
        cityListViewModel.delegate = self
        navigationController.viewControllers = [cityListViewController]
    }

    private func navigateToCityDetails(_ city: AnyObject) {

    }
}

// MARK: -

extension CityCoordinator: CitiesListViewModelDelegate {
    func showCityDetails(_ city: AnyObject) {
        navigateToCityDetails(city)
    }
}
