//
//  CitiesListCoordination.swift
//  CitySearch
//
//  Created by Husein Huseinau on 18.03.2023.
//

import Foundation

protocol CitiesListViewModelCoordination: AnyObject {

    var delegate: CitiesListViewModelDelegate? { get set }

}
