//
//  LocationRouter.swift
//  Places
//
//  Created by Dide van Berkel on 28/10/2023.
//

import MapKit
import SwiftUI

@MainActor
protocol LocationRouterProtocol {
    func presentSearch(for locations: Binding<[Location]>) -> SearchLocationView
}

struct LocationRouter: LocationRouterProtocol {

    func presentSearch(for locations: Binding<[Location]>) -> SearchLocationView {
        let localSearchCompleter = MKLocalSearchCompleter()
        let searchLocationService = SearchLocationService()
        return SearchLocationView(
            viewModel: SearchLocationViewModel(
                localSearchCompleter: localSearchCompleter,
                service: searchLocationService
            ),
            locations: locations
        )
    }
}
