//
//  CitiesCoordinator.swift
//  CitySearch
//
//  Created by Husein Huseinau on 18.03.2023.
//

import UIKit

final class CityCoordinator: BaseCoordinator {

    // MARK: Private Variables

    private weak var navigationController: UINavigationController?
    private let searchEngine: CitiesSearchEngine

    // MARK: Lifecycle

    init(
        navigationController: UINavigationController,
        searchEngine: CitiesSearchEngine
    ) {
        self.navigationController = navigationController
        self.searchEngine = searchEngine
    }

    func start() {
        navigateToCityList()
    }

    private func navigateToCityList() {
        let (cityListViewController, cityListViewModel) = CitiesListBuilder.build(searchEngine: searchEngine)
        cityListViewModel.coordinationDelegate = self
        navigationController?.viewControllers = [cityListViewController]
    }

    private func navigateToCityDetails(_ city: City) {
        let vc = CityDetailsBuilder.build(coordinates: city.coordinates)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: -

extension CityCoordinator: CitiesListViewModelCoordinationDelegate {
    func showCityDetails(_ city: City) {
        navigateToCityDetails(city)
    }
}
