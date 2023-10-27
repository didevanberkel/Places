//
//  URL+Extension.swift
//  Places
//
//  Created by Dide van Berkel on 25/10/2023.
//

import Foundation

extension URL {
    static var locations: URL {
        URL(string: "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json")!
    }

    static func wikipedia(location: Location) -> URL {
        guard let wikipediaUrl = URL(string: "wikipedia://places?longitude=\(location.long)&latitude=\(location.lat)") else {
            return URL(string: "itms-apps://itunes.apple.com/app/id324715238")!
        }
        return wikipediaUrl
    }
}
