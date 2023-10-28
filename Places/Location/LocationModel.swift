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
    let title: String?
    let subtitle: String?
    let lat: Double
    let long: Double

    enum CodingKeys: String, CodingKey {
        case title = "name"
        case subtitle
        case lat
        case long
    }
}
