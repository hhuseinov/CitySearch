//
//  CityDetailsViewModel.swift
//  CitySearch
//
//  Created by Husein Huseinau on 18.03.2023.
//

import Foundation
import CoreLocation

final class CityDetailsViewModel: CityDetailsViewModelPresentation {

    var city: City
    
    init(city: City) {
        self.city = city
    }
}
