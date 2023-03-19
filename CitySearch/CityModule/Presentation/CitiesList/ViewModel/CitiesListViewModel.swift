//
//  CitiesListViewModel.swift
//  CitySearch
//
//  Created by Husein Huseinau on 18.03.2023.
//

import Foundation

final class CitiesListViewModel: CitiesListViewModelCoordination {

    weak var coordinationDelegate: CitiesListViewModelCoordinationDelegate?
    weak var presentationDelegate: CitiesListViewModelPresentationDelegate?

    private let citySearchUseCase: CitySearchUseCase

    // MARK: Lifecycle

    init(citySearchUseCase: CitySearchUseCase) {
        self.citySearchUseCase = citySearchUseCase
    }

    // MARK: Private properties
    private var allCities: [City] = []

    // MARK: Public properties
    var displayCities: ArraySlice<City> = []
}

// MARK: - CitiesListViewModelPresentation

extension CitiesListViewModel: CitiesListViewModelPresentation {
    
    func viewDidLoad() {
        Task(priority: .high) {
            switch await citySearchUseCase.getCitiesList() {
            case let .success(cities):
                allCities = cities
                displayCities = ArraySlice(allCities)
                await MainActor.run {
                    presentationDelegate?.citiesUpdated()
                }
            case .failure(_):
                //TODO: Handle errors
                break
            }
        }
    }
    
    func didSearch(query: String) {
        guard !allCities.isEmpty else { return }
        displayCities = citySearchUseCase.searchForCities(query: query, initialCollection: allCities) ?? []
        presentationDelegate?.citiesUpdated()
    }
    
    func didCancelSearch() {
        displayCities = ArraySlice(allCities)
        presentationDelegate?.citiesUpdated()
    }
    
    func didSelectItem(at index: Int) {
        let city = displayCities[index + displayCities.startIndex]
        coordinationDelegate?.showCityDetails(city)
    }
}
