//
//  SearchEngineTests.swift
//  CitySearchTests
//
//  Created by Husein Huseinau on 19.03.2023.
//

import XCTest
@testable import CitySearch
import CoreLocation

class DefaultSearchEngineTests: XCTestCase {
    
    var searchEngine: DefaultSearchEngine!
    let cities = [
        City(id: 1, coordinates: CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278), name: "London", country: "UK"),
        City(id: 1, coordinates: CLLocationCoordinate2D(latitude: 40.445, longitude: -95.234978), name: "London", country: "US"),
        City(id: 2, coordinates: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060), name: "New York", country: "US"),
        City(id: 3, coordinates: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), name: "San Francisco", country: "US"),
        City(id: 4, coordinates: CLLocationCoordinate2D(latitude: 35.6895, longitude: 139.6917), name: "Tokyo", country: "Japan")
    ]
    
    override func setUp() {
        super.setUp()
        searchEngine = DefaultSearchEngine()
    }
    
    override func tearDown() {
        searchEngine = nil
        super.tearDown()
    }
    
    func testBinarySearchWithNumbers() {
        // Test a basic binary search with a sorted array
        let sortedArray = [1, 3, 5, 7, 9]
        let result = searchEngine.binarySearch(
            array: sortedArray,
            predicate: { $0 == 5 },
            isBiggerThan: { $0 > 5 }
        )
        XCTAssertEqual(result, sortedArray[2...2])
        
        // Test a binary search with an unsorted array
        let unsortedArray = [9, 5, 1, 7, 3]
        let sortedResult = searchEngine.binarySearch(
            array: unsortedArray,
            predicate: { $0 == 5 },
            isBiggerThan: { $0 > 5 }
        )
        XCTAssertEqual(sortedResult, unsortedArray[1...1])
        
        // Test a binary search with an array that doesn't contain the target element
        let missingResult = searchEngine.binarySearch(
            array: sortedArray,
            predicate: { $0 == 4 },
            isBiggerThan: { $0 > 4 }
        )
        XCTAssertNil(missingResult)
    }
    
    func testSearchForCitiesFirstLetter() {
        // Search for cities with name starting with "n"
        let result = searchEngine.searchForCities(query: "n", initialCollection: cities)
        
        XCTAssertEqual(result?.count, 1)
        XCTAssertEqual(result?[0 + (result?.startIndex ?? 0)].id, 2)
        XCTAssertEqual(result?[0 + (result?.startIndex ?? 0)].name, "New York")
        XCTAssertEqual(result?[0 + (result?.startIndex ?? 0)].country, "US")
    }
    
    func testSearchForCitiesWithNonExistentQuery() {
        // Search for cities with name starting with "x"
        let result = searchEngine.searchForCities(query: "x", initialCollection: cities)
        
        XCTAssertNil(result)
    }
    
    func testSearchForCitiesWithEmptyQuery() {
        // Search for cities with empty query
        let result = searchEngine.searchForCities(query: "", initialCollection: cities)
        
        XCTAssertEqual(result?.count, cities.count)
    }
    
    func testSearchForCitiesPrefix() {
        let result = searchEngine.searchForCities(query: "Lon", initialCollection: cities)
        XCTAssertEqual(result?.count, 2)
        XCTAssertEqual(result?.first?.name, "London")
    }
    
    func testSearchForCitiesPrefixLowercase() {
        let result = searchEngine.searchForCities(query: "lon", initialCollection: cities)
        XCTAssertEqual(result?.count, 2)
        XCTAssertEqual(result?.first?.name, "London")
    }
    
    func testSearchForCitiesPrefixUppercase() {
        let result = searchEngine.searchForCities(query: "LON", initialCollection: cities)
        XCTAssertEqual(result?.count, 2)
        XCTAssertEqual(result?.first?.name, "London")
    }
    
    func testSearchForCitiesSameCitiesDifferentCountriesOrder() {
        let result = searchEngine.searchForCities(query: "LON", initialCollection: cities)
        XCTAssertEqual(result?.count, 2)
        XCTAssertEqual(result?.first?.name, "London")
        XCTAssertEqual(result?.first?.country, "UK")
        XCTAssertEqual(result?.last?.name, "London")
        XCTAssertEqual(result?.last?.country, "US")
    }
    
    func testSearchForCitiesNoMatch() {
        let result = searchEngine.searchForCities(query: "Foo", initialCollection: cities)
        XCTAssertNil(result)
    }
}
