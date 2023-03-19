//
//  CitiesListCoordination.swift
//  CitySearch
//
//  Created by Husein Huseinau on 18.03.2023.
//

import Foundation

protocol CitiesListViewModelCoordinationDelegate: AnyObject {
    func showCityDetails(_ city: AnyObject)
}

protocol CitiesListViewModelCoordination: AnyObject {

    var coordinationDelegate: CitiesListViewModelCoordinationDelegate? { get set }

}
