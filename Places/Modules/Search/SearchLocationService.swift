//
//  SearchLocationService.swift
//  Places
//
//  Created by Dide van Berkel on 28/10/2023.
//

import Foundation
import MapKit

enum SearchError: Error {
    case coordinatesNotFound
}

protocol SearchLocationServiceProtocol {
    func getCoordinates(text: String) async throws -> [CLLocationCoordinate2D]
}

struct SearchLocationService: SearchLocationServiceProtocol {
    
    func getCoordinates(text: String) async throws -> [CLLocationCoordinate2D] {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = text
        request.resultTypes = .pointOfInterest

        let search = MKLocalSearch(request: request)
        let response = try await search.start()

        return response.mapItems.compactMap {
            guard let location = $0.placemark.location?.coordinate else { return nil }
            return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        }
    }
}
