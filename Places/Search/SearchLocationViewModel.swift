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
}

extension SearchLocationViewModel: MKLocalSearchCompleterDelegate {

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        locations = completer.results.compactMap {
            let title = $0.title
            let subtitle = $0.subtitle
            let request = MKLocalSearch.Request(completion: $0)
            let coordinate = request.region.center
            return .init(
                name: title,
                subtitle: subtitle,
                lat: coordinate.latitude,
                long: coordinate.longitude
            )
        }
    }
}
