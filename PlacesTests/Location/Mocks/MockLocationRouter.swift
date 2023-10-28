//
//  MockLocationRouter.swift
//  PlacesTests
//
//  Created by Dide van Berkel on 28/10/2023.
//

@testable import Places
import SwiftUI

final class MockLocationRouter: LocationRouterProtocol {
    
    var presentSearchCallsCount = 0
    var presentSearchCalled: Bool {
        presentSearchCallsCount > 0
    }
    var presentSearchReceivedLocations: Binding<[Location]>?
    var presentSearchResult: SearchLocationView?

    func presentSearch(for locations: Binding<[Location]>) -> SearchLocationView {
        presentSearchCallsCount += 1
        presentSearchReceivedLocations = locations
        guard let presentSearchResult = presentSearchResult else {
            fatalError("SearchLocationView not defined")
        }
        return presentSearchResult
    }
}
