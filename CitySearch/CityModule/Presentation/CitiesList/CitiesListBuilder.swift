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

    static func build(searchEngine: CitiesSearchEngine) -> CitiesListBuild {
        let viewModel = CitiesListViewModel(
            citySearchUseCase: makeCitySearchUseCase(searchEngine: searchEngine)
        )
        let viewController = CitiesListViewController.create(with: viewModel)
        return (viewController, viewModel)
    }

    // MARK: Private Methods
    private static func makeCitySearchUseCase(searchEngine: CitiesSearchEngine) -> CitySearchUseCase {
        DefaultCitySearchUseCase(cityRepository: makeCityRepository(), searchEngine: searchEngine)
    }
    
    private static func makeCityRepository() -> CityRepository {
        DefaultCityRepository()
    }
}
