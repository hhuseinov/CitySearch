//
//  DIContainer.swift
//  CitySearch
//
//  Created by Husein Huseinau on 19.03.2023.
//

import Foundation
final class AppDIContainer {
    
    lazy var searchEngine: SearchEngine = {
        DefaultSearchEngine()
    }()
}
