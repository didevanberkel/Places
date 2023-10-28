//
//  MockLocationRouter.swift
//  PlacesTests
//
//  Created by Dide van Berkel on 28/10/2023.
//

@testable import Places
import SwiftUI

final class MockLocationRouter: LocationRouterProtocol {
    
    var searchCallsCount = 0
    var searchCalled: Bool {
        searchCallsCount > 0
    }
    var searchReceivedLocations: Binding<[Location]>?
    var searchResult: SearchLocationView?

    func search(for locations: Binding<[Location]>) -> SearchLocationView {
        searchCallsCount += 1
        searchReceivedLocations = locations
        guard let searchResult = searchResult else {
            fatalError("SearchLocationView not defined")
        }
        return searchResult
    }
}
