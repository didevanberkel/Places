//
//  LocationView.swift
//  Places
//
//  Created by Dide van Berkel on 25/10/2023.
//

import SwiftUI
import MapKit

struct LocationView: View {

    @ObservedObject var viewModel: LocationViewModel

    @State private var showModal = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.locations, id: \.self) { location in
                    Link(location.name ?? Strings.unknownName, destination: URL.wikipedia(location: location))
                }
            }
            .navigationTitle(Strings.locations)
            .navigationBarItems(trailing: addButton)
            .sheet(isPresented: $showModal) {
                SearchLocationView(viewModel: SearchLocationViewModel(localSearchCompleter: MKLocalSearchCompleter(), service: SearchLocationService()), locations: $viewModel.locations)
            }
        }
        .task {
            await viewModel.getLocations()
        }
    }

    private var addButton: some View {
        Button(action: {
            self.showModal.toggle()
        }) {
            Images.add
        }
    }
}

#Preview {
    LocationView(viewModel: LocationViewModel(service: LocationService()))
}
