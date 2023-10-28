//
//  MockSearchLocationService.swift
//  PlacesTests
//
//  Created by Dide van Berkel on 28/10/2023.
//

@testable import Places
import MapKit

extension SearchLocationServiceProtocol { }

final class MockSearchLocationService: SearchLocationServiceProtocol {

    var getCoordinatesCallsCount = 0
    var getCoordinatesCalled: Bool {
        getCoordinatesCallsCount > 0
    }
    var getCoordinatesResult: [CLLocationCoordinate2D]?
    func getCoordinates(text: String) async throws -> [CLLocationCoordinate2D] {
        getCoordinatesCallsCount += 1
        guard let getCoordinatesResult = getCoordinatesResult else {
            throw SearchError.coordinatesNotFound
        }
        return getCoordinatesResult
    }
}
