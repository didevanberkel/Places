//
//  LocationService.swift
//  Places
//
//  Created by Dide van Berkel on 25/10/2023.
//

import Foundation

enum APIError: Error, Equatable {
    case requestError, statusCodeError(Int), decodeError, unknownError
}

protocol LocationServiceProtocol {
    func getLocations(request: URL) async throws -> [Location]
}

struct LocationService: LocationServiceProtocol {
    
    let apiRequest: APIRequestProtocol
    
    func getLocations(request: URL) async throws -> [Location] {
        let result = try await apiRequest.get(request: request)
        switch result {
        case .success(let data):
            guard let result = try? JSONDecoder().decode(Locations.self, from: data) else {
                throw APIError.decodeError
            }
            return result.locations
        case .failure(let error):
            throw error
        }
    }
}
