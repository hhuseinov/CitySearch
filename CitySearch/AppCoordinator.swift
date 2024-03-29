//
//  AppCoordinator.swift
//  CitySearch
//
//  Created by Husein Huseinau on 19.03.2023.
//

import UIKit

protocol BaseCoordinator: AnyObject {}

final class AppCoordinator {

    private let appDIContainer: AppDIContainer
    private var navigationController: UINavigationController
    private var coordinators: [any BaseCoordinator] = .init()
    
    init(
        navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let coordinator = CityCoordinator(
            navigationController: navigationController,
            searchEngine: appDIContainer.searchEngine
        )
        coordinators.append(coordinator)
        coordinator.start()
    }
}
