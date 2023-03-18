//
//  CitiesListBuilder.swift
//  CitySearch
//
//  Created by Husein Huseinau on 18.03.2023.
//

import Foundation
import class UIKit.UIViewController

enum CitiesListBuilder {
    
    // MARK: Typealiases

    typealias CitiesListBuild = (UIViewController, CitiesListViewModelCoordination)

    // MARK: Public Methods

    static func build() -> CitiesListBuild {
        let viewModel = CitiesListViewModel()
        let viewController = CitiesListViewController.fromStoryboard(.city)

        viewController.viewModel = viewModel
        return (viewController, viewModel)
    }
}
