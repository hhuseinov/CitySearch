//
//  CitiesListPresentation.swift
//  CitySearch
//
//  Created by Husein Huseinau on 18.03.2023.
//

import Foundation

protocol CitiesListViewModelPresentationDelegate: AnyObject {
    func citiesUpdated()
}

protocol CitiesListViewModelPresentation: AnyObject {
    
    var displayCities: ArraySlice<City> { get }
    var presentationDelegate: CitiesListViewModelPresentationDelegate? { get set }

    func viewDidLoad()
    func didSearch(query: String)
    func didCancelSearch()
    func didSelectItem(at index: Int)
}
