//
//  CitySearchUseCase.swift
//  CitySearch
//
//  Created by Husein Huseinau on 19.03.2023.
//

import Foundation

protocol CitySearchUseCase {
    func getCitiesList() async -> Result<[City], RequestError>
    func searchForCities(query: String, initialCollection: [City]) -> ArraySlice<City>?
}

protocol CitiesSearchEngine {
    func searchForCities(query: String, initialCollection: [City]) -> ArraySlice<City>?
}

final class DefaultCitySearchUseCase {

    private let cityRepository: CityRepository
    private let searchEngine: CitiesSearchEngine

    init(
        cityRepository: CityRepository,
        searchEngine: CitiesSearchEngine
    ) {
        self.cityRepository = cityRepository
        self.searchEngine = searchEngine
    }
}

extension DefaultCitySearchUseCase: CitySearchUseCase {
    func getCitiesList() async -> Result<[City], RequestError> {
        switch await cityRepository.getCitiesList() {
        case .success(let cities):
            return .success(cities.sorted())
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func searchForCities(query: String, initialCollection: [City]) -> ArraySlice<City>? {
        searchEngine.searchForCities(query: query, initialCollection: initialCollection)
    }
}
