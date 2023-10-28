//
//  LocationViewModel.swift
//  Places
//
//  Created by Dide van Berkel on 25/10/2023.
//

import Foundation
import SwiftUI

@MainActor
final class LocationViewModel: ObservableObject {

    @Published var locations: [Location] = []
    @Published var isError: Bool = false

    private let router: LocationRouterProtocol
    private let service: LocationServiceProtocol

    init(
        router: LocationRouterProtocol,
        service: LocationServiceProtocol
    ) {
        self.router = router
        self.service = service
    }

    /// Asynchronously retrieves locations from the location service and updates the locations property.
    func getLocations() async {
        do {
            locations = try await service.getLocations(request: .locations)
        } catch {
            isError = true
        }
    }

    /// Creates and returns a `SearchLocationView`. It takes a binding, allowing the search view to interact with the underlying data.
    func presentSearch(for locations: Binding<[Location]>) -> SearchLocationView {
        router.presentSearch(for: locations)
    }
}
