//
//  AppCoordinator.swift
//  CitySearch
//
//  Created by Husein Huseinau on 19.03.2023.
//

import UIKit

final class AppCoordinator {

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let flow = CityCoordinator(navigationController: navigationController)
        flow.start()
    }
}
