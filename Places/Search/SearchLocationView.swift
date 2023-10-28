//
//  SearchLocationView.swift
//  Places
//
//  Created by Dide van Berkel on 25/10/2023.
//

import SwiftUI
import MapKit

struct SearchLocationView: View {

    @ObservedObject var viewModel: SearchLocationViewModel
    @Binding var locations: [Location]

    @State private var search: String = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            searchLocationTextField
            searchLocationList
        }
        .padding()
        .onChange(of: search) {
            viewModel.update(with: search)
        }
    }
}

extension SearchLocationView {
    private var searchLocationTextField: some View {
        HStack {
            Images.magnifier
            TextField(Strings.searchLocation, text: $search)
                .autocorrectionDisabled()
        }
        .textFieldBackground()
    }

    private var searchLocationList: some View {
        List {
            ForEach(viewModel.searchResults, id: \.self) { location in
                Button(action: { didTapOnLocation(location) }) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(location.title)
                            .font(.headline)
                            .fontDesign(.rounded)
                        Text(location.subtitle)
                    }
                }
            }
        }
        .listStyle(.plain)
    }

    private func didTapOnLocation(_ location: SearchResult) {
        Task {
            do {
                let result = try await viewModel.didTapOnLocation(location)
                locations.append(result)
                dismiss()
            } catch {
                let result = Location(title: Strings.unknownLocation, subtitle: nil, lat: 0.0, long: 0.0)
                locations.append(result)
                dismiss()
            }
        }
    }
}

#Preview {
    SearchLocationView(
        viewModel: SearchLocationViewModel(
            localSearchCompleter: MKLocalSearchCompleter(),
            service: SearchLocationService()
        ),
        locations: .constant(
            [
                Location(
                    title: "Title",
                    subtitle: "Subtitle",
                    lat: 123.0,
                    long: 1234.0
                )
            ]
        )
    )
}
