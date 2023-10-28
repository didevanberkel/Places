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

    private func didTapOnLocation(_ location: SearchResult) {
        Task {
            do {
                let loc = try await viewModel.didTapOnLocation(location)
                locations.append(loc)
                dismiss()
            } catch {
                // to do: error
            }
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
}

#Preview {
    SearchLocationView(
        viewModel: SearchLocationViewModel(localSearchCompleter: MKLocalSearchCompleter()),
        locations: .constant([Location(name: "Title", subtitle: "Subtitle", lat: 123.0, long: 1234.0)])
    )
}
