//
//  SearchLocationViewModel.swift
//  Places
//
//  Created by Dide van Berkel on 25/10/2023.
//

import Foundation
import MapKit

enum SearchError: Error {
    case coordinatesNotFound
}

@MainActor
class SearchLocationViewModel: NSObject, ObservableObject {

    @Published var searchResults: [SearchResult] = []

    private let localSearchCompleter: MKLocalSearchCompleter

    init(localSearchCompleter: MKLocalSearchCompleter) {
        self.localSearchCompleter = localSearchCompleter
        super.init()
        self.localSearchCompleter.delegate = self
    }

    func update(with text: String) {
        localSearchCompleter.resultTypes = .pointOfInterest
        localSearchCompleter.queryFragment = text
    }

    func didTapOnLocation(_ location: SearchResult) async throws -> Location {
        guard let coordinates = try await getCoordinates(text: "\(location.title), \(location.subtitle)").first else { throw SearchError.coordinatesNotFound }
        return Location(name: location.title, subtitle: location.subtitle, lat: coordinates.latitude, long: coordinates.longitude)
    }

    private func getCoordinates(text: String) async throws -> [CLLocationCoordinate2D] {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = text
        request.resultTypes = .pointOfInterest

        let search = MKLocalSearch(request: request)
        let response = try await search.start()

        return response.mapItems.compactMap {
            guard let location = $0.placemark.location?.coordinate else { return nil }
            return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        }
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
