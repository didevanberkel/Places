//
//  LocationService.swift
//  Places
//
//  Created by Dide van Berkel on 25/10/2023.
//

import Foundation

enum APIError: Error {
    case requestError, statusCodeError, decodeError
}

protocol LocationServiceProtocol {
    func getLocations() async throws -> [Location]
}

struct LocationService: LocationServiceProtocol {

    func getLocations() async throws -> [Location] {
        guard let (data, response) = try? await URLSession.shared.data(from: .locations) else {
            throw APIError.requestError
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.statusCodeError
        }
        guard let result = try? JSONDecoder().decode(Locations.self, from: data) else {
            throw APIError.decodeError
        }
        return result.locations
    }
}
