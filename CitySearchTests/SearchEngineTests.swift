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
        City(id: 1, coordinates: .init(), name: "London", country: "UK"),
        City(id: 1, coordinates: .init(), name: "London", country: "US"),
        City(id: 2, coordinates: .init(), name: "New York", country: "US"),
        City(id: 3, coordinates: .init(), name: "San Francisco", country: "US"),
        City(id: 4, coordinates: .init(), name: "Tokyo", country: "Japan")
    ]
    
    override func setUp() {
        super.setUp()
        searchEngine = DefaultSearchEngine()
    }
    
    override func tearDown() {
        searchEngine = nil
        super.tearDown()
    }
    
    func testBinarySearchWithNumbersSortedArrayMissingResults() {
        // given
        let sortedArray = [1, 3, 5, 7, 9]
        
        // when
        let missingResult = searchEngine.binarySearch(
            array: sortedArray,
            predicate: { $0 == 4 },
            isBiggerThan: { $0 > 4 }
        )
        
        //then
        XCTAssertNil(missingResult)
    }
    
    func testBinarySearchWithNumbersSortedArray() {
        // given
        let sortedArray = [1, 3, 5, 7, 9]
        
        // when
        let result = searchEngine.binarySearch(
            array: sortedArray,
            predicate: { $0 == 5 },
            isBiggerThan: { $0 > 5 }
        )
        
        //then
        XCTAssertEqual(result, sortedArray[2...2])
    }
    
    func testBinarySearchWithNumbersUnsortedArray() {
        // given
        let unsortedArray = [9, 5, 1, 7, 3]
        
        // when
        let sortedResult = searchEngine.binarySearch(
            array: unsortedArray,
            predicate: { $0 == 5 },
            isBiggerThan: { $0 > 5 }
        )
        
        //then
        XCTAssertEqual(sortedResult, unsortedArray[1...1])
    }

    func testSearchForCitiesFirstLetter() {
        // when
        let result = searchEngine.searchForCities(query: "n", initialCollection: cities)
        
        //then
        XCTAssertEqual(result?.count, 1)
        XCTAssertEqual(result?[0 + (result?.startIndex ?? 0)].id, 2)
        XCTAssertEqual(result?[0 + (result?.startIndex ?? 0)].name, "New York")
        XCTAssertEqual(result?[0 + (result?.startIndex ?? 0)].country, "US")
    }
    
    func testSearchForCitiesWithNonExistentQuery() {
        // when
        let result = searchEngine.searchForCities(query: "x", initialCollection: cities)
        
        //then
        XCTAssertNil(result)
    }
    
    func testSearchForCitiesWithEmptyQuery() {
        // when
        let result = searchEngine.searchForCities(query: "", initialCollection: cities)
        
        //then
        XCTAssertEqual(result?.count, cities.count)
    }
    
    func testSearchForCitiesPrefix() {
        // when
        let result = searchEngine.searchForCities(query: "Lon", initialCollection: cities)
        
        //then
        XCTAssertEqual(result?.count, 2)
        XCTAssertEqual(result?.first?.name, "London")
    }
    
    func testSearchForCitiesPrefixLowercase() {
        // when
        let result = searchEngine.searchForCities(query: "lon", initialCollection: cities)
        
        //then
        XCTAssertEqual(result?.count, 2)
        XCTAssertEqual(result?.first?.name, "London")
    }
    
    func testSearchForCitiesPrefixUppercase() {
        // when
        let result = searchEngine.searchForCities(query: "LON", initialCollection: cities)
        
        //then
        XCTAssertEqual(result?.count, 2)
        XCTAssertEqual(result?.first?.name, "London")
    }
    
    func testSearchForCitiesSameCitiesDifferentCountriesOrder() {
        // when
        let result = searchEngine.searchForCities(query: "LON", initialCollection: cities)
        
        //then
        XCTAssertEqual(result?.count, 2)
        XCTAssertEqual(result?.first?.name, "London")
        XCTAssertEqual(result?.first?.country, "UK")
        XCTAssertEqual(result?.last?.name, "London")
        XCTAssertEqual(result?.last?.country, "US")
    }
    
    func testSearchForCitiesNoMatch() {
        // when
        let result = searchEngine.searchForCities(query: "Foo", initialCollection: cities)
        
        //then
        XCTAssertNil(result)
    }
}
