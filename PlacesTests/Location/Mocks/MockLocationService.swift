//
//  MockLocationService.swift
//  PlacesTests
//
//  Created by Dide van Berkel on 26/10/2023.
//

import Foundation
@testable import Places

final class MockLocationService: LocationServiceProtocol {

    var getLocationsCallsCount = 0
    var getLocationsCalled: Bool {
        getLocationsCallsCount > 0
    }
    var getLocationsReceivedRequest: URL?
    var getLocationsResult: [Location]?
    func getLocations(request: URL) async throws -> [Location] {
        getLocationsCallsCount += 1
        getLocationsReceivedRequest = request
        guard let getLocationsResult = getLocationsResult else {
            throw APIError.requestError
        }
        return getLocationsResult
    }
}
