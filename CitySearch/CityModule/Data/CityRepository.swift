//
//  CityRepository.swift
//  CitySearch
//
//  Created by Husein Huseinau on 19.03.2023.
//

import Foundation

protocol CityRepository {
    func getCitiesList() async -> [City]
}

final class DefaultCityRepository: CityRepository {
    func getCitiesList() async -> [City] {
        return []
    }
}
