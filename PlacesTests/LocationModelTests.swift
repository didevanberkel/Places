//
//  LocationModelTests.swift
//  PlacesTests
//
//  Created by Dide van Berkel on 26/10/2023.
//

import XCTest
@testable import Places

@MainActor
final class LocationModelTests: XCTestCase {

    func testDecodeLocationsResponse() {
        // When
        guard let data = try? self.getData(fromJSON: "Locations") else {
            fatalError("Can't find json file")
        }
        let result = try? JSONDecoder().decode(Locations.self, from: data)

        // Then
        XCTAssertEqual(result?.locations.count, 4)

        XCTAssertEqual(result?.locations[0].name, "Amsterdam")
        XCTAssertEqual(result?.locations[0].subtitle, nil)
        XCTAssertEqual(result?.locations[0].lat, 52.3547498)
        XCTAssertEqual(result?.locations[0].long, 4.8339215)

        XCTAssertEqual(result?.locations[1].name, "Mumbai")
        XCTAssertEqual(result?.locations[1].subtitle, nil)
        XCTAssertEqual(result?.locations[1].lat, 19.0823998)
        XCTAssertEqual(result?.locations[1].long, 72.8111468)

        XCTAssertEqual(result?.locations[2].name, "Copenhagen")
        XCTAssertEqual(result?.locations[2].subtitle, nil)
        XCTAssertEqual(result?.locations[2].lat, 55.6713442)
        XCTAssertEqual(result?.locations[2].long, 12.523785)

        XCTAssertEqual(result?.locations[3].name, nil)
        XCTAssertEqual(result?.locations[3].subtitle, nil)
        XCTAssertEqual(result?.locations[3].lat, 40.4380638)
        XCTAssertEqual(result?.locations[3].long, -3.7495758)
    }
}
