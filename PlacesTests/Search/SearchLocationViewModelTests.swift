//
//  SearchLocationViewModelTests.swift
//  PlacesTests
//
//  Created by Dide van Berkel on 26/10/2023.
//

import MapKit
import XCTest
@testable import Places

@MainActor
final class SearchLocationViewModelTests: XCTestCase {
    
    private var mockLocalSearchCompleter: MockLocalSearchCompleter!
    private var mockSearchLocationService: MockSearchLocationService!
    private var sut: SearchLocationViewModel!
    
    override func setUp() async throws {
        mockLocalSearchCompleter = MockLocalSearchCompleter()
        mockSearchLocationService = MockSearchLocationService()
        sut = SearchLocationViewModel(
            localSearchCompleter: mockLocalSearchCompleter,
            service: mockSearchLocationService
        )
    }
    
    override func tearDown() async throws {
        mockLocalSearchCompleter = nil
        mockSearchLocationService = nil
        sut = nil
    }
    
    func testUpdateSearch() {
        // When
        sut.update(with: "text")
        
        // Then
        XCTAssertEqual(mockLocalSearchCompleter.resultTypes, .pointOfInterest)
        XCTAssertEqual(mockLocalSearchCompleter.queryFragment, "text")
    }
    
    func testDidTapOnLocationSuccess() async {
        // Given
        mockSearchLocationService.getCoordinatesResult = [CLLocationCoordinate2D(latitude: 52.356472987284874, longitude: 4.879017482024647)]
        let result = SearchResult(title: "Concertgebouw", subtitle: "Concertgebouwplein 10, 1071 LN, Amsterdam, Netherlands")
        
        // When
        let location = try? await sut.didTapOnLocation(result)
        
        // Then
        XCTAssertTrue(mockSearchLocationService.getCoordinatesCalled)
        XCTAssertEqual(mockSearchLocationService.getCoordinatesCallsCount, 1)
        XCTAssertEqual(location?.title, "Concertgebouw")
        XCTAssertEqual(location?.subtitle, "Concertgebouwplein 10, 1071 LN, Amsterdam, Netherlands")
    }
    
    func testDidTapOnLocationFailure() async {
        // Given
        mockSearchLocationService.getCoordinatesResult = nil
        let result = SearchResult(title: "Concertgebouw", subtitle: "Concertgebouwplein 10, 1071 LN, Amsterdam, Netherlands")
        
        // When
        let location = try? await sut.didTapOnLocation(result)
        
        // Then
        XCTAssertTrue(mockSearchLocationService.getCoordinatesCalled)
        XCTAssertEqual(mockSearchLocationService.getCoordinatesCallsCount, 1)
        XCTAssertNil(location)
    }
}
