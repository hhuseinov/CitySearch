//
//  CitiesListViewModelTests.swift
//  CitySearchTests
//
//  Created by Husein Huseinau on 19.03.2023.
//

import XCTest
@testable import CitySearch

class CitiesListViewModelTests: XCTestCase {

    var viewModel: CitiesListViewModel!
    var citySearchUseCase: CitySearchUseCaseMock!
    let cities = [
        City(id: 1, coordinates: .init(), name: "London", country: "UK"),
        City(id: 1, coordinates: .init(), name: "London", country: "US"),
        City(id: 2, coordinates: .init(), name: "New York", country: "US"),
        City(id: 3, coordinates: .init(), name: "San Francisco", country: "US"),
        City(id: 4, coordinates: .init(), name: "Tokyo", country: "Japan")
    ]
    
    override func setUp() {
        super.setUp()
        citySearchUseCase = CitySearchUseCaseMock()
        viewModel = CitiesListViewModel(citySearchUseCase: citySearchUseCase)
    }

    override func tearDown() {
        viewModel = nil
        citySearchUseCase = nil
        super.tearDown()
    }
    
    func testViewDidLoad() {
        // given
        let expectation = XCTestExpectation(description: "View did load")
        citySearchUseCase.getCitiesListReturnValue = .success(cities)

        // when
        viewModel.viewDidLoad()

        // then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.displayCities, ArraySlice(self.cities))
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testViewDidLoadFailure() {
        // given
        citySearchUseCase.getCitiesListReturnValue = .failure(.decode)

        // when
        viewModel.viewDidLoad()

        // then
        XCTAssertEqual(viewModel.displayCities, [])
    }

    func testDidSearchEmptyQuery() {
        // given
        let expectation = XCTestExpectation(description: "View did load")
        citySearchUseCase.getCitiesListReturnValue = .success(cities)
        viewModel.viewDidLoad()
        citySearchUseCase.searchForCitiesReturnValue = ArraySlice(cities)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // when
            self.viewModel.didSearch(query: "")
            
            // then
            XCTAssertEqual(self.viewModel.displayCities, ArraySlice(self.cities))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }

    func testDidSearchNoResults() {
        // given
        let expectation = XCTestExpectation(description: "View did load")
        citySearchUseCase.getCitiesListReturnValue = .success(cities)
        viewModel.viewDidLoad()
        citySearchUseCase.searchForCitiesReturnValue = ArraySlice<City>()

        XCTAssertEqual(viewModel.displayCities, [])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // when
            self.viewModel.didSearch(query: "Chicago")
            
            // then
            XCTAssertEqual(self.viewModel.displayCities, [])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }

    func testDidSearchWithResults() {
        // given
        let expectation = XCTestExpectation(description: "View did load")
        citySearchUseCase.getCitiesListReturnValue = .success(cities)
        viewModel.viewDidLoad()
        citySearchUseCase.searchForCitiesReturnValue = cities[2...2]

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // when
            self.viewModel.didSearch(query: "New")
            
            // then
            XCTAssertEqual(self.viewModel.displayCities, self.cities[2...2])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }

    func testDidCancelSearch() {
        // given
        let expectation = XCTestExpectation(description: "View did load")
        citySearchUseCase.getCitiesListReturnValue = .success(cities)
        viewModel.viewDidLoad()
        citySearchUseCase.searchForCitiesReturnValue = cities[2...2]

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // when
            self.viewModel.didSearch(query: "New")
            self.viewModel.didCancelSearch()
            
            // then
            XCTAssertEqual(self.viewModel.displayCities, ArraySlice(self.cities))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }

}

class CitySearchUseCaseMock: CitySearchUseCase {

    var getCitiesListReturnValue: Result<[City], RequestError> = .failure(.decode)
    var searchForCitiesReturnValue: ArraySlice<City>?

    func getCitiesList() async -> Result<[City], RequestError> {
        return getCitiesListReturnValue
    }

    func searchForCities(query: String, initialCollection: [City]) -> ArraySlice<City>? {
        return searchForCitiesReturnValue
    }
}
