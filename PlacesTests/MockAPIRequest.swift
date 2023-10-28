//
//  MockAPIRequest.swift
//  PlacesTests
//
//  Created by Dide van Berkel on 28/10/2023.
//

import Foundation
@testable import Places

final class MockAPIRequest: APIRequestProtocol {
    var getCallsCount = 0
    var getCalled: Bool {
        getCallsCount > 0
    }
    var getReceivedRequest: URL?
    var getResult: Result<Data, Error>?
    func get(request: URL) async throws -> Result<Data, Error> {
        getCallsCount += 1
        getReceivedRequest = request
        guard let getResult = getResult else {
            fatalError("Result not specified.")
        }
        return getResult
    }
}
