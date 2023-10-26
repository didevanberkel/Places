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

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search for a location", text: $search)
                    .autocorrectionDisabled()
                    .onSubmit {
                        Task {
                            await viewModel.searchLocations(text: search)
                            locations = viewModel.locations
                        }
                    }
            }
            .modifier(TextFieldGrayBackgroundColor())
            Spacer()
            List {
                ForEach(viewModel.searchResults, id: \.self) { completion in
                    Button(action: { didTapOnCompletion(completion) }) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(completion.title)
                                .font(.headline)
                                .fontDesign(.rounded)
                            Text(completion.subtitle)
                        }
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .onChange(of: search) {
            viewModel.update(with: search)
        }
        .padding()
        .interactiveDismissDisabled()
        .presentationDetents([.height(200), .large])
        .presentationBackground(.regularMaterial)
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
    }

    private func didTapOnCompletion(_ completion: SearchResult) {
        Task {
            await viewModel.searchFirstLocation(text: "\(completion.title) \(completion.subtitle)")
            locations = viewModel.locations
        }
    }
}

struct TextFieldGrayBackgroundColor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(.gray.opacity(0.1))
            .cornerRadius(8)
            .foregroundColor(.primary)
    }
}

#Preview {
    SearchLocationView(
        viewModel: SearchLocationViewModel(localSearchCompleter: MKLocalSearchCompleter()),
        locations: .constant([Location(name: "Deventer", lat: 123.0, long: 1234.0)])
    )
}
