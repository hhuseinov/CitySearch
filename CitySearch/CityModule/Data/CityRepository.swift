//
//  CityRepository.swift
//  CitySearch
//
//  Created by Husein Huseinau on 19.03.2023.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidFile
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .invalidFile:
            return "Invalid url"
        case .unknown:
            return "Unknown error"
        }
    }
}

protocol CityRepository {
    func getCitiesList() async -> Result<[City], RequestError>
}

final class DefaultCityRepository: CityRepository {
    
    let path: String?

    init(path: String?) {
        self.path = path
    }

    func getCitiesList() async -> Result<[City], RequestError> {
        guard let path else {
            return .failure(.invalidFile)
        }
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let cities = try decoder.decode([CityDTO].self, from: jsonData)
                .map { $0.city }
            return .success(cities)
        } catch {
            return .failure(.decode)
        }
    }
}
