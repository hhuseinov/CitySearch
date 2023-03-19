//
//  CityDetailsBuilder.swift
//  CitySearch
//
//  Created by Husein Huseinau on 18.03.2023.
//

import CoreLocation
import UIKit

enum CityDetailsBuilder {

    static func build(coordinates: CLLocationCoordinate2D) -> UIViewController {
        let viewModel = CityDetailsViewModel(
            coordinates: coordinates
        )
        return CityDetailsViewController.create(with: viewModel)
    }
}
