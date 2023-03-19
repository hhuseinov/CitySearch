//
//  CitySearchUseCase.swift
//  CitySearch
//
//  Created by Husein Huseinau on 19.03.2023.
//

import Foundation

protocol CitySearchUseCase {
    func getCitiesList() async -> [City]
    func searchForCities(query: String, initialCollection: [City]) -> ArraySlice<City>
}

final class DefaultCitySearchUseCase {

    private let cityRepository: CityRepository

    init(cityRepository: CityRepository) {
        self.cityRepository = cityRepository
    }
}

extension DefaultCitySearchUseCase: CitySearchUseCase {
    func getCitiesList() async -> [City] {
        return []
    }
    
    func searchForCities(query: String, initialCollection: [City]) -> ArraySlice<City> {
        return []
    }
}
