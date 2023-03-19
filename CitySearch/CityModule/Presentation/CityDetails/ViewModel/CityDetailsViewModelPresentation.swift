//
//  CityDetailsViewModelPresentation.swift
//  CitySearch
//
//  Created by Husein Huseinau on 19.03.2023.
//

import Foundation
import CoreLocation
protocol CityDetailsViewModelPresentation: AnyObject {
    
    var coordinates: CLLocationCoordinate2D { get }
}
