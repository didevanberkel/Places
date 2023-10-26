//
//  LocationViewModelTests.swift
//  PlacesTests
//
//  Created by Dide van Berkel on 25/10/2023.
//

import XCTest
@testable import Places

@MainActor
final class LocationViewModelTests: XCTestCase {
    private var mockLocationService: MockLocationService!
    private var sut: LocationViewModel!

    override func setUp() async throws {
        mockLocationService = MockLocationService()
        sut = LocationViewModel(service: mockLocationService)
    }

    override func tearDown() async throws {
        mockLocationService = nil
        sut = nil
    }

    func testGetLocations() async {
        // Given
        mockLocationService.getLocationsResult = [
            Location(
                name: "name",
                subtitle: "subtitle",
                lat: 100.0,
                long: 200.0
            )
        ]

        // When
        await sut.getLocations()

        // Then
        XCTAssertTrue(mockLocationService.getLocationsCalled)
        XCTAssertEqual(mockLocationService.getLocationsCallsCount, 1)
        XCTAssertEqual(sut.locations[0].name, "name")
        XCTAssertEqual(sut.locations[0].subtitle, "subtitle")
        XCTAssertEqual(sut.locations[0].lat, 100.0)
        XCTAssertEqual(sut.locations[0].long, 200.0)
    }
}
