//
//  LocationViewModelTests.swift
//  PlacesTests
//
//  Created by Dide van Berkel on 25/10/2023.
//

import MapKit
import XCTest
@testable import Places

@MainActor
final class LocationViewModelTests: XCTestCase {
    private var mockLocationRouter: MockLocationRouter!
    private var mockLocationService: MockLocationService!
    private var sut: LocationViewModel!
    
    override func setUp() async throws {
        mockLocationRouter = MockLocationRouter()
        mockLocationService = MockLocationService()
        sut = LocationViewModel(
            router: mockLocationRouter,
            service: mockLocationService
        )
    }
    
    override func tearDown() async throws {
        mockLocationRouter = nil
        mockLocationService = nil
        sut = nil
    }
    
    func testGetLocationsSuccess() async {
        // Given
        mockLocationService.getLocationsResult = [
            Location(
                title: "name",
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
        XCTAssertEqual(sut.locations[0].title, "name")
        XCTAssertEqual(sut.locations[0].subtitle, "subtitle")
        XCTAssertEqual(sut.locations[0].lat, 100.0)
        XCTAssertEqual(sut.locations[0].long, 200.0)
    }
    
    func testGetLocationsFailure() async {
        // Given
        mockLocationService.getLocationsResult = nil
        
        // When
        await sut.getLocations()
        
        // Then
        XCTAssertTrue(mockLocationService.getLocationsCalled)
        XCTAssertEqual(mockLocationService.getLocationsCallsCount, 1)
        XCTAssertEqual(mockLocationService.getLocationsReceivedRequest?.absoluteString, "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json")
        XCTAssertTrue(sut.locations.isEmpty)
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
        mockLocationRouter.searchResult = SearchLocationView(
            viewModel: SearchLocationViewModel(
                localSearchCompleter: MKLocalSearchCompleter(),
                service: SearchLocationService()
            ),
            locations: .constant(locations)
        )
        
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
