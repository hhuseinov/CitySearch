//
//  CityDetailsViewModel.swift
//  CitySearch
//
//  Created by Husein Huseinau on 18.03.2023.
//

import Foundation
import CoreLocation

final class CityDetailsViewModel: CityDetailsViewModelPresentation {

    var coordinates: CLLocationCoordinate2D
    
    init(coordinates: CLLocationCoordinate2D) {
        self.coordinates = coordinates
    }
}
