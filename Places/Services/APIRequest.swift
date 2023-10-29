//
//  APIRequest.swift
//  Places
//
//  Created by Dide van Berkel on 28/10/2023.
//

import Foundation

protocol APIRequestProtocol {
    func get(request: URL) async throws -> Result<Data, Error>
}

final class APIRequest: APIRequestProtocol {

    func get(request: URL) async throws -> Result<Data, Error> {
        guard let (data, response) = try? await URLSession.shared.data(from: .locations) else {
            throw APIError.requestError
        }
        guard let response = response as? HTTPURLResponse else {
            return .failure(APIError.unknownError)
        }
        switch response.statusCode {
        case 200...299:
            return .success(data)
        default:
            return .failure(APIError.statusCodeError(response.statusCode))
        }
    }
}
