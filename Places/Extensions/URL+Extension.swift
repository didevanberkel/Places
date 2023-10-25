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
}
