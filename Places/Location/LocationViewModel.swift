//
//  LocationViewModel.swift
//  Places
//
//  Created by Dide van Berkel on 25/10/2023.
//

import Foundation
import SwiftUI

@MainActor
class LocationViewModel: ObservableObject {

    @Published var locations: [Location] = []

    private let router: LocationRouterProtocol
    private let service: LocationServiceProtocol

    init(
        router: LocationRouterProtocol,
        service: LocationServiceProtocol
    ) {
        self.router = router
        self.service = service
    }
    
    func getLocations() async {
        guard let data = try? await service.getLocations() else {
            self.locations = []
            return
        }
        self.locations = data
    }

    func search(for locations: Binding<[Location]>) -> SearchLocationView {
        router.search(for: locations)
    }
}
