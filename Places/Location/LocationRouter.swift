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
    func search(for locations: Binding<[Location]>) -> SearchLocationView
}

struct LocationRouter: LocationRouterProtocol {

    func search(for locations: Binding<[Location]>) -> SearchLocationView {
        SearchLocationView(
            viewModel: SearchLocationViewModel(
                localSearchCompleter: MKLocalSearchCompleter(),
                service: SearchLocationService()
            ),
            locations: locations
        )
    }
}

