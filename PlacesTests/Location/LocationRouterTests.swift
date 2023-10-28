//
//  LocationRouterTests.swift
//  PlacesTests
//
//  Created by Dide van Berkel on 28/10/2023.
//

import XCTest
@testable import Places

@MainActor
final class LocationRouterTests: XCTestCase {
    private var sut: LocationRouter!
    
    override func setUp() async throws {
        sut = LocationRouter()
    }
    
    override func tearDown() async throws {
        sut = nil
    }
    
    func testSearchForLocation() {
        // Given
        let locations = [
            Location(
                title: "title",
                subtitle: "subtitle",
                lat: 100.0,
                long: 200.0
            )
        ]
        
        // When
        let view = sut.search(for: .constant(locations))
        
        // Then
        XCTAssertNotNil(view)
        XCTAssertEqual(view.locations[0].title, "title")
        XCTAssertEqual(view.locations[0].subtitle, "subtitle")
        XCTAssertEqual(view.locations[0].lat, 100.0)
        XCTAssertEqual(view.locations[0].long, 200.0)
    }
}
