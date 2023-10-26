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

    @Published var locations: [Location] = []
    @Published var searchResults: [SearchResult] = []

    private let localSearchCompleter: MKLocalSearchCompleter

    init(localSearchCompleter: MKLocalSearchCompleter) {
        self.localSearchCompleter = localSearchCompleter
        super.init()
        self.localSearchCompleter.delegate = self
    }

    func searchLocations(text: String) async {
        guard let data = try? await search(text: text) else {
            self.locations = []
            return
        }
        self.locations = data
    }

    func searchFirstLocation(text: String) async {
        guard let data = try? await search(text: text), let first = data.first else {
            self.locations = []
            return
        }
        self.locations = [first]
    }

    private func search(text: String) async throws -> [Location] {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = text
        request.resultTypes = .pointOfInterest

        let search = MKLocalSearch(request: request)
        let response = try await search.start()

        return response.mapItems.compactMap {
            guard let location = $0.placemark.location?.coordinate else { return nil }
            return .init(name: $0.placemark.name, lat: location.latitude, long: location.longitude)
        }
    }

    func update(with text: String) {
        localSearchCompleter.resultTypes = .pointOfInterest
        localSearchCompleter.queryFragment = text
    }
}

extension SearchLocationViewModel: MKLocalSearchCompleterDelegate {

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results.map {
            .init(title: $0.title, subtitle: $0.subtitle)
        }
    }
}
