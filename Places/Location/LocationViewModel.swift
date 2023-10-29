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

    @Published private(set) var state: LoadingState = .idle
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

    /// Asynchronously retrieves locations from the location service and updates the locations property.
    private func getLocations() async {
        state = .loading
        do {
            self.locations = try await service.getLocations(request: .locations)
            state = .success
        } catch {
            state = .error
        }
    }

    /// Creates and returns a `SearchLocationView`. It takes a binding, allowing the search view to interact with the underlying data.
    func presentSearch(for locations: Binding<[Location]>) -> SearchLocationView {
        router.presentSearch(for: locations)
    }
}

extension LocationViewModel: LoadingProtocol {

    func load() async {
        await getLocations()
    }
}
