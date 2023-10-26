//
//  SearchLocationViewModelTests.swift
//  PlacesTests
//
//  Created by Dide van Berkel on 26/10/2023.
//

import XCTest
@testable import Places

@MainActor
final class SearchLocationViewModelTests: XCTestCase {

    private var mockLocalSearchCompleter: MockLocalSearchCompleter!
    private var sut: SearchLocationViewModel!

    override func setUp() async throws {
        mockLocalSearchCompleter = MockLocalSearchCompleter()
        sut = SearchLocationViewModel(localSearchCompleter: mockLocalSearchCompleter)
    }

    override func tearDown() async throws {
        mockLocalSearchCompleter = nil
        sut = nil
    }

    func testUpdate() {
        // When
        sut.update(with: "text")

        // Then
        XCTAssertEqual(mockLocalSearchCompleter.resultTypes, .pointOfInterest)
        XCTAssertEqual(mockLocalSearchCompleter.queryFragment, "text")
    }
}
