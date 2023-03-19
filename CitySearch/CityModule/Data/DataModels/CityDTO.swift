//
//  CityDTO.swift
//  CitySearch
//
//  Created by Husein Huseinau on 19.03.2023.
//

import Foundation
import CoreLocation

// MARK: - Data Transfer Object
struct CityDTO: Decodable {
    let country: String
    let name: String
    let id: Int
    let coordinates: CoordinatesDTO
    
    private enum CodingKeys: String, CodingKey {
        case country
        case name
        case id = "_id"
        case coordinates = "coord"
    }
    
    struct CoordinatesDTO: Decodable {
        let longitude: Double
        let latitude: Double
        
        private enum CodingKeys: String, CodingKey {
            case longitude = "lon"
            case latitude = "lat"
        }
        
        var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
    
    var city: City {
        City(id: id, coordinates: coordinates.coordinate, name: name, country: country)
    }
}
