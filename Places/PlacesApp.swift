//
//  PlacesApp.swift
//  Places
//
//  Created by Dide van Berkel on 25/10/2023.
//

import SwiftUI

@main
struct PlacesApp: App {

    var body: some Scene {
        let locationViewModel = LocationViewModel(
            router: LocationRouter(),
            service: LocationService()
        )
        WindowGroup {
            LocationView(viewModel: locationViewModel)
        }
    }
}
