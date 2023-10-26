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
                Images.magnifier
                TextField(Strings.searchLocation, text: $search)
                    .autocorrectionDisabled()
            }
            .modifier(TextFieldGrayBackgroundColor())
            Spacer()
            List {
                ForEach(viewModel.locations, id: \.self) { location in
                    Button(action: { didTapOnCompletion(location) }) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(location.name ?? "")
                                .font(.headline)
                                .fontDesign(.rounded)
                            Text(location.subtitle ?? "")
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

    private func didTapOnCompletion(_ completion: Location) {
        locations.append(completion)
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
        locations: .constant([Location(name: "Title", subtitle: "Subtitle", lat: 123.0, long: 1234.0)])
    )
}
