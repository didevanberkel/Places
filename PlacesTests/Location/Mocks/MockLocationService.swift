//
//  MockLocationService.swift
//  PlacesTests
//
//  Created by Dide van Berkel on 26/10/2023.
//

@testable import Places

extension LocationServiceProtocol { }

final class MockLocationService: LocationServiceProtocol {

    var getLocationsCallsCount = 0
    var getLocationsCalled: Bool {
        getLocationsCallsCount > 0
    }
    var getLocationsResult: [Location]?
    func getLocations() async throws -> [Location] {
        getLocationsCallsCount += 1
        guard let getLocationsResult = getLocationsResult else {
            throw APIError.requestError
        }
        return getLocationsResult
    }
}
