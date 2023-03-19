//
//  CitySearchUseCaseTests.swift
//  CitySearchTests
//
//  Created by Husein Huseinau on 19.03.2023.
//

import Foundation
@testable import CitySearch
import XCTest

class DefaultCitySearchUseCaseTests: XCTestCase {

    var cityRepository: MockCityRepository!
    var citiesSearchEngine: MockCitiesSearchEngine!
    var citySearchUseCase: CitySearchUseCase!
    
    override func setUp() {
        super.setUp()
        cityRepository = MockCityRepository()
        citiesSearchEngine = MockCitiesSearchEngine()
        citySearchUseCase = DefaultCitySearchUseCase(
            cityRepository: cityRepository,
            searchEngine: citiesSearchEngine
        )
    }
    
    func testGetCitiesListSuccessAndSorted() async {
        // given
        let expectedCities = [
            City(id: 707860, coordinates: .init(), name: "Hurzuf", country: "UA"),
            City(id: 519188, coordinates: .init(), name: "Novinki", country: "RU"),
            City(id: 1283378, coordinates: .init(), name: "Gorkhā", country: "NP"),
            City(id: 1270260, coordinates: .init(), name: "State of Haryāna", country: "IN")
        ]
        cityRepository.getCitiesListReturnValue = .success(expectedCities)
        
        // when
        let result = await citySearchUseCase.getCitiesList()
        
        //then
        XCTAssertEqual(result, .success(expectedCities.sorted()))
    }
    
    func testGetCitiesListFailure() async {
        // given
        cityRepository.getCitiesListReturnValue = .failure(.unknown)
        
        // when
        let result = await citySearchUseCase.getCitiesList()
        
        //then
        XCTAssertEqual(result, .failure(.unknown))
    }
    
    func testSearchForCitiesSuccess() {
        // given
        let query = "query"
        let expectedCities: [City] = [
            City(id: 1, coordinates: .init(), name: "City1", country: "Country1"),
            City(id: 2, coordinates: .init(), name: "City2", country: "Country2")
        ]
        let expectedResults: ArraySlice<City> = expectedCities[0...0]
        citiesSearchEngine.searchForCitiesReturnValue = expectedResults
        
        // when
        let result = citySearchUseCase.searchForCities(query: query, initialCollection: expectedCities)
        
        //then
        XCTAssertEqual(result, expectedResults)
    }
}

class MockCityRepository: CityRepository {
    var getCitiesListCalled = false
    var getCitiesListReturnValue: Result<[City], RequestError>!
    
    func getCitiesList() async -> Result<[City], RequestError> {
        getCitiesListCalled = true
        return getCitiesListReturnValue
    }
}

class MockCitiesSearchEngine: CitiesSearchEngine {
    var searchForCitiesCalled = false
    var searchForCitiesReturnValue: ArraySlice<City>?
    
    func searchForCities(query: String, initialCollection: [City]) -> ArraySlice<City>? {
        searchForCitiesCalled = true
        return searchForCitiesReturnValue
    }
}
