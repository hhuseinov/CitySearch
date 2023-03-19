//
//  SearchEngine.swift
//  CitySearch
//
//  Created by Husein Huseinau on 19.03.2023.
//

import Foundation

typealias SearchEngine = CitiesSearchEngine

private protocol SearchMethods {
    /**
        Caution: Do not pass unsorted array to binary search, set shouldSortBeforeSearch to true, or sort it before method usage.
     */
    func binarySearch<T: Comparable>(
        array: [T],
        shouldSortBeforeSearch: Bool,
        predicate: (T) -> Bool,
        isBiggerThan: (T) -> Bool
    ) -> ArraySlice<T>?
}

final class DefaultSearchEngine: SearchMethods {
    func binarySearch<T>(
        array: [T],
        shouldSortBeforeSearch: Bool,
        predicate: (T) -> Bool,
        isBiggerThan: (T) -> Bool
    ) -> ArraySlice<T>? where T : Comparable {
        var left = 0
        var right = array.count - 1

        while left <= right {
            let mid = (left + right) / 2
            
            if predicate(array[mid]) {
                // expand range to include adjacent elements that also satisfy the predicate
                var start = mid
                var end = mid
                while start > 0 && predicate(array[start-1]) {
                    start -= 1
                }
                while end < array.count-1 && predicate(array[end+1]) {
                    end += 1
                }
                return array[start...end]
            } else if isBiggerThan(array[mid]) {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return nil
    }
}

extension DefaultSearchEngine: CitiesSearchEngine {
    func searchForCities(query: String, initialCollection: [City]) -> ArraySlice<City>? {
        binarySearch(
            array: initialCollection,
            shouldSortBeforeSearch: false,
            predicate: {
                $0.name.lowercased().hasPrefix(query.lowercased())
                
            },
            isBiggerThan: {
                $0.name.lowercased() < query.lowercased()
                
            }
        )
    }
}
