//
//  CityRepositoryTests.swift
//  CitySearchTests
//
//  Created by Husein Huseinau on 19.03.2023.
//

import XCTest
@testable import CitySearch
import CoreLocation

class DefaultCityRepositoryTests: XCTestCase {

    func testGetCitiesListSuccess() async {
        // given
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "correct", ofType: "json") else {
            XCTFail("Failed to load JSON file")
            return
        }
        let repository = DefaultCityRepository(path: path)
        
        // when
        let result = await repository.getCitiesList()

        //then
        switch result {
        case .success(let cities):
            XCTAssertEqual(cities.count, 4)
            let expectedCities = [
                City(id: 707860, coordinates: CLLocationCoordinate2D(latitude: 44.549999, longitude: 34.283333), name: "Hurzuf", country: "UA"),
                City(id: 519188, coordinates: CLLocationCoordinate2D(latitude: 55.683334, longitude: 37.666668), name: "Novinki", country: "RU"),
                City(id: 1283378, coordinates: CLLocationCoordinate2D(latitude: 28, longitude: 84.633331), name: "Gorkhā", country: "NP"),
                City(id: 1270260, coordinates: CLLocationCoordinate2D(latitude: 29, longitude: 76), name: "State of Haryāna", country: "IN")
            ]
            XCTAssertEqual(cities, expectedCities)
        case .failure:
            XCTFail("Expected success, got failure")
        }
    }

    func testGetCitiesListDecodeError() async {
        // given
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "decodeError", ofType: "json") else {
            XCTFail("Failed to load JSON file")
            return
        }
        let repository = DefaultCityRepository(path: path)
        
        // when
        let result = await repository.getCitiesList()

        //then
        switch result {
        case .success:
            XCTFail("Expected failure, got success")
        case .failure(let error):
            XCTAssertEqual(error, .decode)
        }
    }
}
