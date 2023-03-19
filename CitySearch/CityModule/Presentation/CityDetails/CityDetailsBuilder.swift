//
//  CityDetailsBuilder.swift
//  CitySearch
//
//  Created by Husein Huseinau on 18.03.2023.
//

import CoreLocation
import UIKit

enum CityDetailsBuilder {

    static func build(city: City) -> UIViewController {
        let viewModel = CityDetailsViewModel(
            city: city
        )
        return CityDetailsViewController.create(with: viewModel)
    }
}
