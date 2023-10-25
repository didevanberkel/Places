//
//  LocationViewModel.swift
//  Places
//
//  Created by Dide van Berkel on 25/10/2023.
//

import Foundation

@MainActor
class LocationViewModel: ObservableObject {

    @Published var locations: [Location] = []

    private let service: LocationServiceProtocol

    init(service: LocationServiceProtocol) {
        self.service = service
    }
    
    func getLocations() async {
        guard let data = try? await service.getLocations() else {
            self.locations = []
            // TODO: error flow
            return
        }
        self.locations = data
    }
}
