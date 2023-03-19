//
//  City.swift
//  CitySearch
//
//  Created by Husein Huseinau on 19.03.2023.
//

import Foundation
import CoreLocation

struct City: Comparable, Identifiable {

    static func == (lhs: City, rhs: City) -> Bool {
        lhs.id == rhs.id
    }

    static func < (lhs: City, rhs: City) -> Bool {
        lhs.name.compare(rhs.name) == .orderedAscending
    }

    typealias Identifier = Int
    let id: Identifier
    let coordinates: CLLocationCoordinate2D
    let name: String
    let country: String
}
