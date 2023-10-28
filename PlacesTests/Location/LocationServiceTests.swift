//
//  LocationServiceTests.swift
//  PlacesTests
//
//  Created by Dide van Berkel on 28/10/2023.
//

import XCTest
@testable import Places

final class LocationServiceTests: XCTestCase {

    private var mockApiRequest: MockAPIRequest!
    private var sut: LocationService!

    override func setUp() async throws {
        mockApiRequest = MockAPIRequest()
        sut = LocationService(apiRequest: mockApiRequest)
    }

    override func tearDown() async throws {
        mockApiRequest = nil
        sut = nil
    }

    func testGetLocationsSuccess() async {
        // Given
        guard let data = try? self.getData(fromJSON: "Locations") else {
            fatalError("Can't find json file")
        }
        mockApiRequest.getResult = .success(data)

        // When
        let result = try? await sut.getLocations(request: .locations)

        // Then
        XCTAssertTrue(mockApiRequest.getCalled)
        XCTAssertEqual(mockApiRequest.getCallsCount, 1)
        XCTAssertEqual(mockApiRequest.getReceivedRequest?.absoluteString, "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json")
        XCTAssertEqual(result?.count, 4)

        XCTAssertEqual(result?[0].title, "Amsterdam")
        XCTAssertEqual(result?[0].subtitle, nil)
        XCTAssertEqual(result?[0].lat, 52.3547498)
        XCTAssertEqual(result?[0].long, 4.8339215)

        XCTAssertEqual(result?[1].title, "Mumbai")
        XCTAssertEqual(result?[1].subtitle, nil)
        XCTAssertEqual(result?[1].lat, 19.0823998)
        XCTAssertEqual(result?[1].long, 72.8111468)

        XCTAssertEqual(result?[2].title, "Copenhagen")
        XCTAssertEqual(result?[2].subtitle, nil)
        XCTAssertEqual(result?[2].lat, 55.6713442)
        XCTAssertEqual(result?[2].long, 12.523785)

        XCTAssertEqual(result?[3].title, nil)
        XCTAssertEqual(result?[3].subtitle, nil)
        XCTAssertEqual(result?[3].lat, 40.4380638)
        XCTAssertEqual(result?[3].long, -3.7495758)
    }

    func testGetLocationsRequestFailure() async {
        // Given
        mockApiRequest.getResult = .failure(APIError.requestError)

        // When
        var apiError: Error?
        var result: [Location]?

        do {
            result = try await sut.getLocations(request: .locations)
        } catch {
            apiError = error
        }

        // Then
        XCTAssertTrue(mockApiRequest.getCalled)
        XCTAssertEqual(mockApiRequest.getCallsCount, 1)
        XCTAssertNil(result)
        XCTAssertEqual(apiError as? APIError, .requestError)
    }

    func testGetLocationsStatusCodeError() async {
        // Given
        mockApiRequest.getResult = .failure(APIError.statusCodeError(404))

        // When
        var apiError: Error?
        var result: [Location]?

        do {
            result = try await sut.getLocations(request: .locations)
        } catch {
            apiError = error
        }

        // Then
        XCTAssertTrue(mockApiRequest.getCalled)
        XCTAssertEqual(mockApiRequest.getCallsCount, 1)
        XCTAssertNil(result)
        XCTAssertEqual(apiError as? APIError, .statusCodeError(404))
    }

    func testGetLocationsUnknownError() async {
        // Given
        mockApiRequest.getResult = .failure(APIError.unknownError)

        // When
        var apiError: Error?
        var result: [Location]?

        do {
            result = try await sut.getLocations(request: .locations)
        } catch {
            apiError = error
        }

        // Then
        XCTAssertTrue(mockApiRequest.getCalled)
        XCTAssertEqual(mockApiRequest.getCallsCount, 1)
        XCTAssertNil(result)
        XCTAssertEqual(apiError as? APIError, .unknownError)
    }
}
