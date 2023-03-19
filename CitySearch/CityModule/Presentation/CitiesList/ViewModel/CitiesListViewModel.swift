//
//  CitiesListViewModel.swift
//  CitySearch
//
//  Created by Husein Huseinau on 18.03.2023.
//

import Foundation

final class CitiesListViewModel: CitiesListViewModelCoordination {

    weak var delegate: CitiesListViewModelDelegate?
    private let citySearchUseCase: CitySearchUseCase

    // MARK: Lifecycle

    init(citySearchUseCase: CitySearchUseCase) {
        self.citySearchUseCase = citySearchUseCase
    }

    // MARK: Private methods


    // MARK: Private properties

}

// MARK: - CitiesListViewModelPresentation

extension CitiesListViewModel: CitiesListViewModelPresentation {

}
