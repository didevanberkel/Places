//
//  SearchLocationViewModel.swift
//  Places
//
//  Created by Dide van Berkel on 25/10/2023.
//

import Foundation
import MapKit

@MainActor
class SearchLocationViewModel: NSObject, ObservableObject {

    @Published var searchResults: [SearchResult] = []

    private let localSearchCompleter: MKLocalSearchCompleter
    private let service: SearchLocationServiceProtocol

    init(
        localSearchCompleter: MKLocalSearchCompleter,
        service: SearchLocationServiceProtocol
    ) {
        self.localSearchCompleter = localSearchCompleter
        self.service = service
        super.init()
        self.localSearchCompleter.delegate = self
    }

    func update(with text: String) {
        localSearchCompleter.resultTypes = .address
        localSearchCompleter.queryFragment = text
    }

    func didTapOnLocation(_ location: SearchResult) async throws -> Location {
        guard let coordinates = try await service.getCoordinates(text: "\(location.title), \(location.subtitle)").first else { throw SearchError.coordinatesNotFound }
        return Location(
            title: location.title,
            subtitle: location.subtitle,
            lat: coordinates.latitude,
            long: coordinates.longitude
        )
    }
}

extension SearchLocationViewModel: MKLocalSearchCompleterDelegate {

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results.compactMap {
            return .init(
                title: $0.title,
                subtitle: $0.subtitle
            )
        }
    }
}
