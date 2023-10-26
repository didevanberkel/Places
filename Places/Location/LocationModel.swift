//
//  LocationModel.swift
//  Places
//
//  Created by Dide van Berkel on 25/10/2023.
//

struct Locations: Codable {
    let locations: [Location]
}

struct Location: Hashable, Codable {
    let name: String?
    let subtitle: String?
    let lat: Double
    let long: Double
}
